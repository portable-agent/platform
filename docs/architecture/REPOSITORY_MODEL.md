# Модель репозиториев и организации

Целевая структура GitHub — Organization, а не набор модулей в одном репозитории.

```text
portable-agent organization
├── .github                              organization profile, templates, reusable workflows
├── portable-agent-platform              architecture, catalog, docs portal, platform decisions
├── portable-agent-contracts             OpenAPI, AsyncAPI, JSON Schema, generated documentation
├── portable-agent-gitops                environment state consumed by Argo CD
├── portable-agent-infrastructure         Terraform/OpenTofu and cluster bootstrap
├── portable-agent-template-java          Spring Boot golden path
├── portable-agent-template-python        FastAPI agent golden path
├── portable-agent-template-typescript    Node/MCP golden path
├── portable-agent-channel-gateway        independently deployed service
├── portable-agent-conversation-service   independently deployed service
├── portable-agent-agent-runtime          independently deployed service
├── portable-agent-action-service         independently deployed service
├── portable-agent-approval-service       independently deployed service
├── portable-agent-policy-bundle          independently released policy bundle
├── portable-agent-mcp-gateway            independently deployed service
├── portable-agent-calendar-mcp            independently deployed MCP server
└── portable-agent-widget-sdk              independently published package
```

## Правила

- Никаких Git submodules и multi-service Gradle, Maven, pnpm или Python workspace.
- У каждого deployable-репозитория свои `Dockerfile`, тесты, миграции, SBOM, image, release и SLO.
- Organization reusable workflows стандартизируют поставку, но репозитории вызывают их явно.
- Шаблоны сервисов дают стартовую точку; созданные сервисы не наследуют исходный код шаблонов.
- GitOps использует неизменяемые image digests и никогда не собирает application code.
- Межсервисная интеграция проверяется версионируемыми контрактами и consumer tests.

Bootstrap-контракты пока находятся в репозитории платформы, чтобы проверить архитектуру до создания
Organization. После создания `portable-agent-contracts` они один раз переедут туда вместе с историей.
Это не runtime coupling.
