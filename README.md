# Portable Agent Platform

Платформа переносимого персонального AI-агента: пользователь формулирует намерение голосом или текстом,
проверяет предложенное действие в виджете и безопасно выполняет его в подключённых сервисах через MCP.

Это отдельный продукт. Он не является продолжением репозитория `planner` и не зависит от него.

## Роль репозитория

Этот репозиторий хранит платформенную архитектуру, каталог микросервисов, межсервисные контракты,
локальное окружение, GitOps-конфигурацию и общие правила разработки. Код сервисов будет находиться в
отдельных репозиториях и выпускаться независимо.

## Первый вертикальный сценарий

```text
Telegram voice
  -> Channel Gateway
  -> Speech-to-Text
  -> Conversation Service
  -> Agent Service
  -> Action Proposed
  -> Policy + Approval Widget
  -> MCP Gateway
  -> Calendar MCP
  -> Action Completed
```

## Документация

- [Целевая архитектура](docs/architecture/PLATFORM.md)
- [Каталог сервисов](catalog/services.yaml)
- [Порядок поставки](docs/delivery/ROADMAP.md)
- [ADR: polyrepo](docs/adr/0001-polyrepo.md)
- [ADR: event-driven workflows](docs/adr/0002-event-driven-workflows.md)

