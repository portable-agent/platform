# Текущее состояние по репозиториям

Дата среза: 25 сентября 2026 года. Этот файл обновляется после проверенного локального этапа или мержа,
а не после незавершённого эксперимента.

| Репа | Что меняем или добавляем | Ожидаемый результат | Фактический результат | Следующий шаг |
|---|---|---|---|---|
| `.github` | Общие workflows и правила | Одинаковый CI/CD для всех сервисов | Java, Python, Node, docs, security и container workflows работают; чистый Trivy runner исправлен | Подключать правила к каждой новой репе |
| `contracts` | Версионируемые внешние и внутренние API | Один проверяемый источник сетевых DTO | Release `2.5.0` опубликован с checksum и provenance; общий MessageContext устраняет циклические OpenAPI-ссылки | Использовать release во всех новых адаптерах |
| `action-service` | Подтверждение и надёжное выполнение | `AWAITING_APPROVAL → APPROVED → EXECUTING → SUCCEEDED/FAILED` | jOOQ, outbox, Temporal worker и вызов MCP Gateway работают; решение приходит через Channel Gateway | Оставить источником истины для решения и статуса |
| `calendar-mcp` | `create_event` | Идемпотентное создание fake-события | Fake Calendar, OIDC и защита от дублей работают в общем сценарии | Добавить Google provider за тем же контрактом |
| `mcp-gateway` | OIDC, allowlist и MCP client | Безопасный stateless-маршрутизатор | Foundation смержен и проверен вызовом Calendar MCP | Добавлять коннекторы только по контракту |
| `deploy` | Приложения в локальном Compose | Одна команда поднимает вертикальный backend-срез | Реальный Telegram webhook, Keycloak Device Flow и полный backend работают локально | Сохранить real Telegram N2N как ручной smoke |
| `test-lab` | Календарный acceptance-тест | Один JWT и один контракт на всём пути | Карточка, решение через Gateway, Temporal, offset и отсутствие дубля проверены | Добавить black-box сценарий Telegram и Google stub |
| `agent-runtime` | Текст в предложение действия | Типизированное предложение встречи без скрытого выполнения | Технический ISO-формат работает, но не является пользовательским интерфейсом | Добавить `IntentModel`, естественный язык и structured output |
| `channel-gateway` | Общий вход каналов | Web и Telegram используют один контракт | Сообщение идёт через Conversation; решение канала — через Gateway в Action | Проверить Telegram в общем Compose-сценарии |
| `conversation-service` | Состояние диалога и прикладная оркестрация | Повтор сообщения не создаёт второе действие | PostgreSQL, lease, Agent → Action, карточка и сохранение offset проверены общим E2E | Оставить владельцем диалога при подключении адаптера |
| `widget-sdk` | Карточка подтверждения | Один UI-контракт для разных каналов | Renderer-neutral core создаёт проверенную decision command; Telegram использует тот же сетевой контракт | Добавить готовые helpers для следующих UI-каналов |
| `telegram-adapter` | Telegram как сменный канал | Telegram identity привязывается только после входа через Keycloak | Настоящий бот и webhook проверены; Device Flow завершает привязку, refresh token зашифрован | Проверить естественную фразу и реальный календарь |

## Что уже проверено

```text
русский текст
    -> Channel Gateway
    -> Agent Runtime
    -> предложение calendar.create_event
    -> Action Service и явное подтверждение
    -> Temporal workflow
    -> MCP Gateway
    -> Calendar MCP
    -> fake-событие без изменения исходного +03:00
```

Проверка запускает реальные контейнеры отдельных репозиториев по закреплённым commit SHA. Последний
GitHub acceptance для `deploy` прошёл 25 сентября 2026 года после явного checkout Conversation Service.
Telegram Adapter отдельно проверен unit-, contract- и PostgreSQL integration-тестами и production build.

## Текущий порядок

```text
[готово] contracts 2.2.0
    -> [готово] MCP Gateway и Calendar MCP
    -> [готово] Action Service и Temporal worker
    -> [готово] Channel Gateway и Agent Runtime в общем Compose
    -> [готово] backend acceptance
    -> [решено] Conversation Service владеет диалогом и цепочкой Agent → Action
    -> [готово] contracts 2.3.0: диалог и карточка подтверждения
    -> [готово] Widget SDK 0.1.0
    -> [готово] каркас Conversation Service
    -> [готово] privacy-first решение и идемпотентное хранение
    -> [готово] durable processing и защита нескольких worker
    -> [готово] вызов Agent Runtime и создание Action
    -> [готово] переключение Channel Gateway
    -> [готово] решение виджета через Channel Gateway
    -> [решено] Telegram identity привязывается через OAuth Device Flow
    -> [готово] Telegram adapter: webhook, `/link`, polling и зашифрованная связь
    -> [готово] refresh access token и сообщение через Gateway
    -> [готово] confirmation-кнопки с одноразовым callback и lease
    -> [готово] публичная репа, CI и container image
    -> [готово] Keycloak client, fake Telegram API и Compose E2E
    -> [готово] настоящий Telegram bot, webhook и Device Flow
    -> [следом] естественный язык и уточнения в Agent Runtime
    -> [затем] Google Calendar provider и OAuth
    -> [после real N2N] trace в Tempo и связанные логи в Loki/Grafana
```

## Правило результата

`Ожидаемый результат` описывается до реализации. `Фактический результат` меняется только после проверки
и мержа. Если результаты не совпали, следующий этап не начинается: сначала фиксируется причина,
исправление или отдельное архитектурное решение.
