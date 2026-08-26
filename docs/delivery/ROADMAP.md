# Дорожная карта поставки

## Фаза 0 — Основа платформы

- GitHub Organization, Teams, CODEOWNERS, защищённые ветки и rulesets репозиториев.
- Переиспользуемый CI для Java, Python, TypeScript, контейнеров, политик и контрактов.
- Публикация в GHCR с SBOM, provenance, attestations и vulnerability gates.
- Публичная документация Docusaurus и совместимые с Backstage метаданные каталога.
- Локальный PostgreSQL, Kafka, Keycloak, Temporal, OPA и стек observability.
- Development-кластер Kubernetes, Helm charts, Argo CD и External Secrets.

## Фаза 1 — Первый вертикальный срез

- Channel Gateway и Telegram adapter.
- Conversation Service и Agent Runtime.
- Action и Approval services с Temporal.
- OPA policy bundle.
- MCP Gateway и Calendar MCP.
- Widget SDK и confirmation card.

Definition of Done: голосовая команда создаёт явно подтверждённое событие календаря; весь путь виден в
распределённых трассировках и аудиторской записи.

## Фаза 2 — Укрепление продукта

- Multi-tenancy и подключения каждого пользователя.
- Rate limits, quotas и контроль стоимости моделей.
- Обработка dead-letter и эксплуатационные runbook-файлы.
- SLO, alerts, backup/restore и учение по disaster recovery.
- Web/PWA-клиент и версионируемый Widget SDK.

## Фаза 3 — Высокорисковые действия

- Wallet connector в режимах read-only и simulation.
- Предпросмотр комиссии и policy limits.
- Step-up authentication и неизменяемые approvals.
- Ограниченный пилот переводов после threat modeling и независимого security review.
