# Repository and organization model

The target GitHub layout is an Organization, not a collection of modules in one repository.

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

## Rules

- No Git submodules and no multi-service Gradle, Maven, pnpm, or Python workspace.
- Every deployable repository has its own `Dockerfile`, tests, migrations, SBOM, image, release, and SLO.
- Organization reusable workflows standardize delivery but repositories call them explicitly.
- Service templates provide a starting point; generated services do not inherit source code from templates.
- GitOps consumes immutable image digests and never builds application code.
- Cross-service integration is validated through versioned contracts and consumer tests.

The bootstrap contracts currently live in the platform repository so architecture can be validated before
the Organization exists. They move once, with history, into `portable-agent-contracts` when that repository
is created. This is not a runtime coupling.

