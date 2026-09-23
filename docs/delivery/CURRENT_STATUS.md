# Текущее состояние по репозиториям

Дата среза: 23 сентября 2026 года. Этот файл обновляется после проверенного локального этапа или мержа,
а не после незавершённого эксперимента.

| Репа | Что меняем или добавляем | Ожидаемый результат | Фактический результат | Следующий шаг |
|---|---|---|---|---|
| `.github` | Общие workflows и правила | Одинаковый CI/CD для всех сервисов | Java, Python, Node, docs, security и container workflows работают; чистый Trivy runner исправлен | Подключать правила к каждой новой репе |
| `contracts` | Версионируемые внешние и внутренние API | Один проверяемый источник сетевых DTO | Локальный bundle `2.5.0`: сообщения, confirmation card и решение через Gateway | Выпустить после восстановления GitHub |
| `action-service` | Подтверждение и надёжное выполнение | `AWAITING_APPROVAL → APPROVED → EXECUTING → SUCCEEDED/FAILED` | jOOQ, outbox, Temporal worker и вызов MCP Gateway работают; backend acceptance зелёный | Принимать команду через Channel Gateway |
| `calendar-mcp` | `create_event` | Идемпотентное создание fake-события | Fake Calendar, OIDC и защита от дублей работают в общем сценарии | Оставить эталонным fake-коннектором |
| `mcp-gateway` | OIDC, allowlist и MCP client | Безопасный stateless-маршрутизатор | Foundation смержен и проверен вызовом Calendar MCP | Добавлять коннекторы только по контракту |
| `deploy` | Приложения в локальном Compose | Одна команда поднимает вертикальный backend-срез | Весь срез с Conversation поднимается; Gateway связан с Conversation и Action | Обновить старый локальный Keycloak volume или использовать чистое окружение |
| `test-lab` | Календарный acceptance-тест | Один JWT и один контракт на всём пути | 19/19: карточка, решение через Gateway, Temporal, offset и отсутствие дубля | Добавить первый адаптер канала |
| `agent-runtime` | Текст в предложение действия | Детерминированное предложение встречи без скрытого выполнения | API `2.1.0`, проверка JWT и календарное предложение работают в общем сценарии | Вызывать через Channel Gateway, AI-модель пока не выбирать |
| `channel-gateway` | Общий вход каналов | Web и Telegram используют один контракт | Сообщение идёт через Conversation; команда Widget SDK — через Gateway в Action | Подключить первый адаптер |
| `conversation-service` | Состояние диалога и прикладная оркестрация | Повтор сообщения не создаёт второе действие | PostgreSQL, lease, Agent → Action, карточка и сохранение offset проверены общим E2E | Оставить владельцем диалога при подключении адаптера |
| `widget-sdk` | Карточка подтверждения | Один UI-контракт для разных каналов | Renderer-neutral core создаёт проверенную decision command | Подключить к Telegram adapter |

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
зелёный запуск вошёл в `deploy` через merge `722d33f`.

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
    -> [следом] Telegram adapter
```

## Правило результата

`Ожидаемый результат` описывается до реализации. `Фактический результат` меняется только после проверки
и мержа. Если результаты не совпали, следующий этап не начинается: сначала фиксируется причина,
исправление или отдельное архитектурное решение.
