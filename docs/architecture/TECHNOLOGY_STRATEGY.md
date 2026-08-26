# Technology strategy

Portable Agent is polyglot by design, but not polyglot by accident. The supported language set is limited
to Java, Python, and TypeScript until a measured requirement justifies another runtime.

| Workload | Technology | Why |
|---|---|---|
| Transactional core | Java 25, Spring Boot 4 | Strong consistency tooling, mature persistence and observability ecosystem |
| Durable workflows | Temporal Java SDK | Long-running actions, retries, timers, approvals, compensation, and replay |
| Agent runtime | Python, FastAPI, Pydantic | First-class model, evaluation, retrieval, and scientific ecosystem |
| Channels and BFF | TypeScript, Node.js | Fast API adaptation and shared types with web clients |
| MCP gateway/connectors | TypeScript first; Python or Java when provider libraries require it | Tier-1 MCP ecosystem and fast connector development |
| Web and Widget SDK | TypeScript, React | Portable typed UI contracts and broad contributor familiarity |
| Policy decisions | Open Policy Agent, Rego | Reviewable policy-as-code separated from application code |
| Identity | Keycloak, OIDC/OAuth 2.1 | Standards-based self-hosted identity and federation |
| Events | Kafka | Durable integration events, replay, fan-out, and ecosystem support |
| Data | PostgreSQL per service; Redis for ephemeral state | Explicit ownership and operational maturity |
| Telemetry | OpenTelemetry, Prometheus, Grafana, Loki, Tempo | Vendor-neutral metrics, logs, and traces |
| Delivery | OCI, Kubernetes, Helm, Argo CD, External Secrets | Reproducible images and GitOps-based deployment |

## What we intentionally avoid

- A different language for every service.
- Shared domain-model libraries across repositories.
- A custom workflow engine built on Kafka consumers and database status columns.
- Kubernetes before local containers and contracts are reliable.
- Backstage as a runtime dependency. It is a developer portal and catalog projection only.
- New infrastructure without an owner, runbook, health signal, and failure mode.

