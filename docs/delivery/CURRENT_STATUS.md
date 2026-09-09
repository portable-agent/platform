# Текущее состояние по репозиториям

Дата среза: 10 сентября 2026 года. Этот файл обновляется после мержа этапа, а не после локального
эксперимента.

| Репа | Что меняем или добавляем | Ожидаемый результат | Фактический результат | Следующий шаг |
|---|---|---|---|---|
| `.github` | Общие workflows и правила | Одинаковый CI/CD для всех сервисов | Java, Python, Node, docs, security и container workflows готовы | Подключить ruleset новой репы |
| `contracts` | MCP Gateway API `1.2.0` | Проверяемый контракт worker → gateway | Ветка и тесты готовы, PR ещё не смержен | Смержить и выпустить `1.2.0` |
| `action-service` | Lifecycle и Temporal worker | `APPROVED → EXECUTING → SUCCEEDED/FAILED` | Lifecycle смержен, полного worker ещё нет | Вызвать MCP Gateway из workflow |
| `calendar-mcp` | `create_event` | Идемпотентное создание fake-события | MCP, OIDC и fake-calendar работают | Подключить в общий E2E |
| `mcp-gateway` | OIDC, allowlist и MCP client | Безопасный stateless-маршрутизатор | Репа создана; локальные тесты и Docker зелёные; PR ещё не смержен | Смержить foundation |
| `deploy` | Gateway и worker в Compose/Helm | Одна команда поднимает вертикальный срез | Базовая платформа работает без gateway | Добавить chart и config gateway |
| `test-lab` | Полный календарный acceptance-тест | Повтор запроса не создаёт дубль | Есть тестовый фундамент | Пройти путь через Temporal и gateway |
| `agent-runtime` | Разбор команды в action | Детерминированное предложение встречи | Пока технический каркас | Начать после backend E2E |
| `channel-gateway` | Общий вход каналов | Web и Telegram используют один контракт | Репа не создана | После backend E2E |
| `widget-sdk` | Карточка подтверждения | Один UI-контракт для разных каналов | Репа не создана | После Channel Gateway |

## Текущий порядок

```text
contracts 1.2.0
    -> mcp-gateway foundation
    -> action-service Temporal worker
    -> deploy
    -> test-lab E2E
    -> channel-gateway
    -> widget-sdk
    -> telegram-adapter
```

## Правило результата

`Ожидаемый результат` описывается до реализации. `Фактический результат` меняется только после проверки
и мержа. Если результаты не совпали, следующий этап не начинается: сначала фиксируется причина,
исправление или отдельное архитектурное решение.
