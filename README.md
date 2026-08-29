# Portable Agent Platform

Открытая платформа переносимого персонального AI-агента. Пользователь формулирует намерение голосом или
текстом, проверяет детерминированное действие в независимом от канала виджете и безопасно выполняет его
через MCP-инструменты.

Это отдельный продукт, не связанный с существующим репозиторием `planner`.

## Назначение репозитория

Этот репозиторий — управляющий слой платформы: архитектура, межсервисные контракты, каталог сервисов,
документация разработчика, GitOps-конфигурация и общие инженерные стандарты. Каждый deployable-сервис
находится в собственной GitHub-репе, владеет своими данными и имеет независимый pipeline.

Это намеренно не монорепозиторий: здесь нет модулей реализации сервисов.

## Созданные репозитории

- [`.github`](https://github.com/portable-agent/.github) — общие шаблоны и CI/CD.
- [`platform`](https://github.com/portable-agent/platform) — архитектура и общая документация.
- [`contracts`](https://github.com/portable-agent/contracts) — OpenAPI, AsyncAPI и JSON Schema.
- [`action-service`](https://github.com/portable-agent/action-service) — каркас Java-сервиса действий.
- [`agent-runtime`](https://github.com/portable-agent/agent-runtime) — каркас Python-сервиса агента.
- [`deploy`](https://github.com/portable-agent/deploy) — Helm charts и проверка установки в k3d.

Текущий код сервисов — инженерный каркас. Правила бизнеса ещё не зафиксированы.

## Первый вертикальный срез

```text
Telegram voice -> STT -> Conversation -> Agent -> Proposed action
               -> Policy -> Confirmation widget -> Durable workflow
               -> MCP Gateway -> Calendar -> Result + audit trail
```

## Архитектура

- [Архитектура платформы](docs/architecture/PLATFORM.md)
- [Последовательность выполнения действия](docs/architecture/ACTION_EXECUTION.md)
- [Технологическая стратегия](docs/architecture/TECHNOLOGY_STRATEGY.md)
- [Tech radar](docs/architecture/TECH_RADAR.md)
- [Модель репозиториев и организации](docs/architecture/REPOSITORY_MODEL.md)
- [Правила разработки](docs/development.md)
- [Диагностика документации](docs/runbook.md)
- [Каталог сервисов](catalog/services.yaml)
- [Дорожная карта поставки](docs/delivery/ROADMAP.md)
- [Пошаговый план инженерных работ](docs/delivery/WORK_PLAN.md)
- [План MVP: месяц, полгода и год](docs/delivery/MVP_ROADMAP.md)
- [Полигон тестирования и масштабирования](docs/delivery/TEST_PLATFORM.md)
- [Записи архитектурных решений](docs/adr/)

## Открытый проект

Portable Agent Platform распространяется по лицензии Apache License 2.0. Перед участием ознакомьтесь с
[правилами внесения изменений](CONTRIBUTING.md), [моделью управления](GOVERNANCE.md),
[кодексом поведения](CODE_OF_CONDUCT.md) и [политикой безопасности](SECURITY.md).
