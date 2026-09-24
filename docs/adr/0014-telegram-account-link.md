# ADR-0014: Telegram связывается с identity через Device Flow

- Status: accepted
- Date: 2026-09-25

## Контекст

Telegram update содержит внешний user id, но не содержит JWT Portable Agent. Если Gateway будет доверять
этому id, адаптер сможет выдать себя за любого пользователя. Пароль пользователя также нельзя передавать
боту или сохранять в адаптере.

## Решение

Команда `/link` начинает OAuth 2.0 Device Authorization Grant в Keycloak. Пользователь открывает ссылку,
входит в Keycloak и подтверждает одноразовый код. После подтверждения адаптер получает короткий access
token и refresh token.

Access token используется для вызова Channel Gateway от имени пользователя. Refresh token шифруется
AES-256-GCM до записи в отдельную базу Telegram Adapter. Ключ приходит из secret manager и не хранится
в Git. Telegram user id остаётся только внешним ключом канала.

## Границы

- Telegram Adapter отвечает за webhook, account link и формат Telegram.
- Keycloak подтверждает identity и выпускает токены.
- Channel Gateway продолжает проверять JWT и не доверяет заголовкам с внешним user id.
- Conversation Service хранит диалог.
- Action Service принимает решение и выполняет действие.

## Последствия

- первый вход требует открыть страницу Keycloak;
- адаптер хранит зашифрованную связь и становится stateful;
- нужны polling, `/unlink`, отзыв refresh token и ротация ключа;
- такой же подход можно повторить для VK и других каналов без изменения Gateway.
