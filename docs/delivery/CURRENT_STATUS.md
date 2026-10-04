# Текущее состояние по репозиториям

Дата среза: 4 октября 2026 года. Этот файл обновляется после проверенного локального этапа или мержа,
а не после незавершённого эксперимента.

| Репа | Что меняем или добавляем | Ожидаемый результат | Фактический результат | Следующий шаг |
|---|---|---|---|---|
| `.github` | Общие workflows и правила | Одинаковый CI/CD для всех сервисов | Java, Python, Node, docs, security и container workflows работают; чистый Trivy runner исправлен | Подключать правила к каждой новой репе |
| `contracts` | Версионируемые внешние и внутренние API | Один проверяемый источник сетевых DTO | Release `3.0.0` опубликован; в контракт добавлены trusted execution context, Connection API и Google Calendar connector | Проверять совместимость следующих составных планов |
| `action-service` | Подтверждение и надёжное выполнение | `AWAITING_APPROVAL → APPROVED → EXECUTING → SUCCEEDED/FAILED` | jOOQ, outbox и Temporal работают; workflow имеет типизированные input/output, Search Attributes и стратегию вызова по `ActionKind` | Оставить источником истины для решения и статуса; подготовить границу составного плана |
| `calendar-mcp` | `create_event` | Один MCP-контракт для fake и Google | Fake и Google providers, trusted owner, OIDC и защита от дублей реализованы | Провести ручной Google sandbox N2N |
| `mcp-gateway` | OIDC, allowlist и MCP client | Безопасный stateless-маршрутизатор | Foundation смержен и проверен вызовом Calendar MCP | Добавлять коннекторы только по контракту |
| `connection-service` | Подключения внешних аккаунтов | OAuth и токены не принадлежат каналу или MCP | Google OAuth, зашифрованные подключения, public API и internal token API реализованы | Проверить обновление токена в ручном Google sandbox N2N |
| `deploy` | Приложения в локальном Compose | Одна команда поднимает вертикальный backend-срез | Все девять pin'ов совпадают с актуальными `main`; real Telegram, opt-in Qwen, Connection Service и observability profile подключены | Выполнить локальный reset старой Temporal history и ручной Google N2N |
| `test-lab` | Календарный acceptance-тест | Один JWT и один контракт на всём пути | Fake E2E и opt-in AI E2E работают; 4 октября полный `Agent → Calendar` acceptance прошёл на актуальных pin'ах | Добавить отдельный Google API stub и сценарий обновления токена |
| `agent-runtime` | Текст в предложение действия | Типизированное предложение встречи без скрытого выполнения | `IntentModel`, demo и OpenAI-compatible provider работают; runtime выбирает `google-calendar`, когда он доступен, и fake как fallback | Добавить уточнение при неполных данных и затем составной план |
| `channel-gateway` | Общий вход каналов | Web и Telegram используют один контракт | Сообщение идёт через Conversation; решение канала — через Gateway в Action | Проверить Telegram в общем Compose-сценарии |
| `conversation-service` | Состояние диалога и прикладная оркестрация | Повтор сообщения не создаёт второе действие | PostgreSQL, lease, Agent → Action, карточка и сохранение offset проверены общим E2E | Оставить владельцем диалога при подключении адаптера |
| `widget-sdk` | Карточка подтверждения | Один UI-контракт для разных каналов | Renderer-neutral core создаёт проверенную decision command; Telegram использует тот же сетевой контракт | Добавить готовые helpers для следующих UI-каналов |
| `telegram-adapter` | Telegram как сменный канал | Telegram identity привязывается только после входа через Keycloak | Настоящий бот и webhook проверены; Device Flow завершает привязку, сообщение объясняет автоматическую подстановку кода | Проверить естественную фразу с реальным Google Calendar |

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
GitHub acceptance для `deploy` прошёл 4 октября 2026 года. Он использовал актуальные `main` всех девяти
сервисов и Test Lab. Автономный CI намеренно остаётся на fake-провайдере и не требует внешнего аккаунта.

Отдельно реализованы Google OAuth, выдача короткоживущего access token и Google provider в Calendar MCP.
Их общий ручной sandbox N2N после обновления Temporal history ещё должен быть повторно проверен.

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
    -> [готово] естественный язык через OpenAI-compatible provider и локальную Qwen
    -> [решено] Google OAuth принадлежит Connection Service, а не каналу или MCP
    -> [готово] trusted execution context и Connection Service
    -> [готово] Google Calendar provider и выбор provider в Agent Runtime
    -> [готово] типизированный Action Workflow и понятные поля в Temporal UI
    -> [следом] ручной Telegram → Google Calendar sandbox N2N
    -> [затем] RFC составного плана: несколько последовательных действий из одного сообщения
    -> [после real N2N] trace в Tempo и связанные логи в Loki/Grafana
```

## Правило результата

`Ожидаемый результат` описывается до реализации. `Фактический результат` меняется только после проверки
и мержа. Если результаты не совпали, следующий этап не начинается: сначала фиксируется причина,
исправление или отдельное архитектурное решение.
