# Платформа разработчика

## Путь нового сервиса

```text
1. infra/github-service -> отдельная GitHub repo + team + ruleset
2. .github templates    -> test + security + container + SBOM + signature
3. deploy/new-service   -> values для local, dev и stage
4. pull request         -> быстрые config checks
5. Argo CD              -> общий Helm chart -> Kubernetes
6. test-lab             -> smoke -> load -> ручной resilience
```

## Источники правды

| Данные | Репозиторий | Файл |
|---|---|---|
| Границы продукта и общие ADR | `platform` | `docs/` |
| API и события | `contracts` | OpenAPI, AsyncAPI, JSON Schema |
| Код и техническая карточка | репа сервиса | `SERVICE.md` |
| GitHub rules | `infra` | `modules/github-service` |
| CI/CD | `.github` | reusable workflows |
| Образы и локальные версии | `deploy` | `config/versions.env` |
| Окружения и release values | `deploy` | `environments/` |
| Системные тесты | `test-lab` | `tests/` и `chaos/` |

## Проверки

PR выполняет быстрые тесты и render конфигурации. Полный k3d smoke и расширенный k6 запускаются по
расписанию или вручную. Chaos всегда требует отдельный флаг и label namespace; production запрещён.

## Что намеренно не решено

- облако и production topology;
- настоящий secret manager;
- production SLO и размер кластера;
- первый пользовательский сценарий и бизнес-границы сервисов.

Эти решения нельзя получить из популярности технологии. Следующий этап начинается с product RFC и
сквозного acceptance-теста.

