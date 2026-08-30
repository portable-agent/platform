# ADR 0010: платформа разработки до бизнес-кода

Статус: принято.

## Контекст

Каждый сервис живёт в отдельной репе. Без общих правил это быстро создаёт разные pipelines,
Kubernetes-манифесты и локальные окружения. До выбора первого бизнес-сценария нужен проверяемый
инженерный путь от новой репы до тестового окружения.

## Решение

- Compose поднимает PostgreSQL, Redpanda, Keycloak, Temporal, OPA и observability локально.
- Один Helm chart запускает stateless-сервисы с безопасными defaults.
- Argo CD ApplicationSet читает values из local, dev и stage.
- OpenTofu создаёт GitHub-репу и правила main.
- Общие workflows выполняют test, security scan, container build, SBOM, provenance и Cosign.
- `test-lab` хранит k6 и ручные Chaos Mesh сценарии.
- Секреты, production-адреса и Terraform state не хранятся в Git.

## Границы

Production не создаётся этим решением. SLO, модель данных и список сервисов определяются только после
выбора пользовательского сценария. Stage не получает автоматический sync.

## Последствия

Изменение общего chart или workflow имеет большой радиус влияния и требует smoke-теста. Новый сервис
создаётся из фабрики и шаблона, а не копированием старой репы.

