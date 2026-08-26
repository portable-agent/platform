# Delivery roadmap

## Этап 0 — Platform foundation

- GitHub Organization, Teams, CODEOWNERS и protected branches.
- Reusable CI для Java, TypeScript, containers и contracts.
- GHCR, SBOM, provenance, attestations и vulnerability gates.
- Локальный Kafka/PostgreSQL/Keycloak/observability stack.
- Kubernetes dev-кластер, Helm и Argo CD.

## Этап 1 — Первый вертикальный срез

- `channel-gateway`
- `conversation-service`
- `agent-service`
- `action-service`
- `policy-service`
- `mcp-gateway`
- `calendar-mcp`
- Telegram adapter и confirmation widget

Definition of Done: голосовая команда создаёт подтверждённую встречу, вся цепочка видна в trace и audit.

## Этап 2 — Product hardening

- Multi-tenancy и per-user connections.
- Rate limits, quotas и cost controls.
- Dead-letter handling и operational runbooks.
- SLO, alerts, backup/restore и disaster-recovery exercise.
- Web/PWA и Widget SDK.

## Этап 3 — High-risk actions

- Wallet connector в read-only режиме.
- Simulation и fee preview.
- Step-up authentication, limits и immutable approvals.
- Ограниченный transfer pilot после security review.

