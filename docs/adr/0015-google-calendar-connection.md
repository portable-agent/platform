# ADR-0015: Google Calendar подключается через отдельный Connection Service

- Status: accepted
- Date: 2026-09-26

## Контекст

`calendar-mcp` уже выполняет подтверждённую команду, но сейчас пишет событие только в память.
Настоящий Google Calendar требует OAuth-доступ конкретного пользователя. Refresh token нельзя хранить
в Telegram Adapter, Action Service или MCP-коннекторе: иначе смена канала либо провайдера переносит
секреты в бизнес-сервисы.

Action Service уже сохраняет проверенные `tenantId` и `actorId` из JWT. При выполнении Temporal
использует service account, поэтому обычный `sub` этого токена обозначает сервис, а не владельца
календаря. Нельзя молча подменять его пользовательским идентификатором.

## Решение

### Connection Service

Создаём отдельный `connection-service`. Он отвечает только за подключения внешних аккаунтов:

- запускает Google OAuth 2.0 Authorization Code flow;
- проверяет одноразовый `state` и использует PKCE;
- запрашивает `access_type=offline` и минимальный scope `calendar.events`;
- связывает подключение с `tenantId` и `actorId` из проверенного Portable Agent JWT;
- хранит refresh token в PostgreSQL только в зашифрованном виде;
- получает новый короткоживущий access token и отдаёт его только разрешённому сервису;
- отключает подключение и обрабатывает истёкший либо отозванный token.

Ключ шифрования приходит из secret manager. В Git, логах, событиях и Temporal history нет Google
client secret, authorization code, access token или refresh token.

### Доверенный контекст выполнения

Модель предлагает только данные встречи и не выбирает внешний аккаунт. Action Service загружает
сохранённое действие и передаёт `tenantId`, `actorId`, `actionId` и `requestKey` как отдельный
доверенный execution context. MCP Gateway принимает этот контекст только от service account Action
Service. Пользовательские JSON-поля не могут переопределить его.

Calendar MCP передаёт `tenantId` и `actorId` в Connection Service. Тот находит активное подключение
Google Calendar этого пользователя и возвращает короткоживущий access token. Refresh token никогда
не покидает Connection Service.

Если подключений нет или их несколько без выбранного default, действие не выполняется скрытно.
Пользователь получает понятный результат `connection_required` или выбирает календарь до нового
подтверждения.

### Провайдер календаря

В `calendar-mcp` остаётся один use case `create_event` и две стратегии:

- `fake-calendar` — детерминированный CI и локальная разработка без внешнего аккаунта;
- `google-calendar` — ручной sandbox N2N и дальнейшие окружения.

Google-адаптер использует Calendar API `events.insert` и scope
`https://www.googleapis.com/auth/calendar.events`. Идентификатор события вычисляется из стабильного
`tenantId + actorId + requestKey`, кодируется в допустимый Google формат base32hex и передаётся как
`event.id`. Повтор после сетевой ошибки делает `events.get`: он возвращает прежнее событие вместо
создания дубля. В `extendedProperties.private` сохраняется обезличенный hash request key для
диагностики, но не исходная пользовательская фраза.

## Границы API

- Публичные OAuth start/callback/disconnect принадлежат Connection Service.
- Внутренний token endpoint требует service JWT с audience `connection-service` и scope
  `connection:token`.
- Calendar MCP не принимает refresh token через MCP tool.
- MCP Gateway не хранит токены и не выбирает календарь.
- Action Service не шифрует provider credentials и не вызывает Google API.
- Telegram показывает ссылку подключения, но не становится владельцем Google OAuth-сессии.

## Порядок реализации

1. Добавить контракт доверенного execution context и тест, что его нельзя подменить payload-ом.
2. Создать `connection-service` с PostgreSQL, jOOQ, шифрованием и Google OAuth stub.
3. Добавить contract-тесты start/callback/refresh/revoke без настоящего Google аккаунта.
4. Разделить `CalendarRepository` на хранилище fake-событий и стратегию внешнего провайдера.
5. Добавить Google strategy и WireMock-совместимый stub Calendar API.
6. Включить ручной sandbox N2N только через локальные secrets.
7. После подтверждённого N2N добавить trace и безопасные логи по всему пути.

## Последствия

- появляется отдельный stateful security-сервис и ещё одна БД;
- настоящий календарь нельзя завершить одним изменением только в `calendar-mcp`;
- fake-сценарий остаётся быстрым и доступным каждому contributor;
- новые Jira, Outlook и другие OAuth-подключения используют тот же Connection Service, но отдельные
  provider adapters;
- первый ручной запуск потребует создать Google OAuth client и разрешённый redirect URI вне Git.

## Источники

- [Google OAuth для server-side приложений](https://developers.google.com/identity/protocols/oauth2/web-server)
- [Google OAuth best practices](https://developers.google.com/identity/protocols/oauth2/resources/best-practices)
- [Google Calendar: создание события](https://developers.google.com/workspace/calendar/api/v3/reference/events/insert)
- [Google Calendar: свои event ID](https://developers.google.com/workspace/calendar/api/guides/create-events)
