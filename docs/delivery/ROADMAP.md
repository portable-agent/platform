# Delivery roadmap

## Phase 0 — Platform foundation

- GitHub Organization, Teams, CODEOWNERS, protected branches, and repository rulesets.
- Reusable CI for Java, Python, TypeScript, containers, policies, and contracts.
- GHCR publishing with SBOM, provenance, attestations, and vulnerability gates.
- Public Docusaurus documentation and Backstage-compatible catalog metadata.
- Local PostgreSQL, Kafka, Keycloak, Temporal, OPA, and observability stack.
- Kubernetes development cluster, Helm charts, Argo CD, and External Secrets.

## Phase 1 — First vertical slice

- Channel Gateway and Telegram adapter.
- Conversation Service and Agent Runtime.
- Action and Approval services with Temporal.
- OPA policy bundle.
- MCP Gateway and Calendar MCP.
- Widget SDK and confirmation card.

Definition of Done: a voice command creates an explicitly approved calendar event; the entire path is
visible in distributed traces and an audit record.

## Phase 2 — Product hardening

- Multi-tenancy and per-user connections.
- Rate limits, quotas, and model cost controls.
- Dead-letter handling and operational runbooks.
- SLOs, alerts, backup/restore, and disaster-recovery exercise.
- Web/PWA client and versioned Widget SDK.

## Phase 3 — High-risk actions

- Wallet connector in read-only and simulation modes.
- Fee preview and policy limits.
- Step-up authentication and immutable approvals.
- Limited transfer pilot after threat modeling and an independent security review.

