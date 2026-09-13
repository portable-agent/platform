# Модель репозиториев и организации

Portable Agent использует GitHub Organization и отдельную репу для каждого сервиса.

## Уже создано

| Репозиторий | Что хранит | Состояние |
|---|---|---|
| `.github` | Общие шаблоны, правила и CI/CD | Создан, развивается |
| `platform` | Архитектура, ADR, карта и публичная документация | Создан, сайт опубликован |
| `contracts` | OpenAPI, AsyncAPI, JSON Schema и примеры | Bundle `2.1.0` выпущен и используется сервисами |
| `action-service` | Java-сервис действий | jOOQ, MVC, outbox и Temporal worker работают в backend-срезе |
| `agent-runtime` | Python-сервис агента | MVC, JWT и предложение календарного действия работают в backend-срезе |
| `deploy` | Compose, Helm charts и тестовые окружения | Локальный backend-срез и GitHub acceptance проходят одной командой |
| `infra` | OpenTofu modules и тесты инфраструктуры | Создан, первый module test проходит в CI |
| `test-lab` | Сквозные, нагрузочные и resilience-тесты | Контрактный календарный acceptance-тест готов |
| `calendar-mcp` | MCP-интеграция календаря | Fake Calendar, OIDC и идемпотентность работают в общем сценарии |
| `mcp-gateway` | Безопасный вызов настроенных MCP-сервисов | Stateless-маршрутизатор работает между Action и Calendar MCP |

Каркас означает, что настроены структура и инженерные проверки. Это не означает, что правила бизнеса уже
спроектированы или реализованы.

## Запланировано

```text
portable-agent organization
├── channel-gateway         единый вход для каналов
├── conversation-service    состояние диалога
├── approval-service        подтверждение действий
├── policy-bundle           правила OPA
└── widget-sdk              переносимые виджеты
```

Названия и границы запланированных репозиториев могут измениться до начала реализации.

## Правила

- Никаких Git submodules и общей multi-service сборки.
- У каждого запускаемого сервиса свои `Dockerfile`, тесты, миграции, image, release и runbook.
- Общие workflows задают одинаковые проверки, но каждая репа вызывает их явно.
- GitOps использует готовые image digests и не собирает application code.
- Сервисы не делят общие доменные классы.
- Межсервисные границы описываются в `contracts`, выпускаются версионным bundle и проверяются consumer
  tests.
- Сервисы генерируют только HTTP models и API interfaces; domain остаётся внутри сервиса.
- README и AGENTS.md обновляются вместе с изменением ответственности или команд.
