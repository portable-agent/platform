# Полигон тестирования и масштабирования

Полигон нужен до MVP. Он использует fake-адаптеры и синтетические данные, поэтому позволяет проверять
архитектуру без реального календаря, кошелька, Jira и AI-провайдера.

## Окружения

| Окружение | Для чего | Жизненный цикл | Данные |
|---|---|---|---|
| `compose` | быстрый цикл разработчика | вручную, минуты | синтетические |
| `local-k3d` | Kubernetes, Helm и отказ pod | вручную, часы | синтетические |
| `pr-<number>` | изоляция pull request | создаётся и удаляется CI | синтетические |
| `dev` | совместная интеграция | постоянно | тестовые |
| `stage` | проверка релиз-кандидата | постоянно, похоже на production | обезличенные тестовые |
| `prod` | реальные пользователи | после MVP | минимально необходимые |

## Планируемые репозитории

- `deploy` — Helm charts, Argo CD applications и настройки окружений;
- `infra` — OpenTofu modules, policy checks и тесты инфраструктуры;
- `test-lab` — end-to-end, contract, k6 и chaos-сценарии.

Создавать их нужно по одному. Первый pull request каждого репозитория обязан содержать README,
`AGENTS.md`, владельца, CI и один работающий тест.

## Пирамида проверок

1. Unit: чистые правила и ошибки на границах.
2. Component: контроллер, сервис и repository отдельно.
3. Integration: настоящие PostgreSQL/Kafka/Temporal через Testcontainers.
4. Contract: OpenAPI, AsyncAPI, JSON Schema и backward compatibility.
5. End-to-end: весь путь через fake AI и fake MCP.
6. Load: smoke, baseline, stress, spike и soak.
7. Resilience: pod kill, latency, dependency error и retry storm.
8. Security: SAST, dependency scan, image scan, secrets, SBOM и signature.
9. Restore: восстановление БД и повторная доставка незавершённых действий.

## TDD для системного сценария

```text
acceptance test (red)
  -> contract test (red)
    -> service unit test (red)
      -> минимальный код
    -> integration test (green)
  -> end-to-end test (green)
-> load/resilience test
```

Fake-компоненты реализуют те же контракты, что реальные интеграции. Тест не должен зависеть от
случайного ответа AI: в CI используется детерминированный ответ.

## Лестница нагрузки

Числа являются первичной гипотезой и уточняются после первого baseline.

- smoke: 1 пользователь, 1 минута;
- baseline: 50 запросов в секунду, 15 минут;
- stress: плавный рост до точки насыщения;
- spike: краткий рост в 5 раз от подтверждённого baseline;
- soak: 25 запросов в секунду, 2 часа;
- distributed: только когда один k6 process действительно стал ограничением.

Для API без внешней AI-модели начальные gates: error rate менее 1%, p95 менее 500 ms и отсутствие
потерянных действий. Это не обещание production SLO. Реальные SLO принимаются по пользовательским
сценариям и измерениям.

## Что измеряем

- latency p50/p95/p99;
- throughput и active users;
- error rate по типу ошибки;
- CPU, memory, connection pools и queue lag;
- время workflow и число retry;
- дубли, потерянные действия и размер dead-letter;
- стоимость одного завершённого сценария;
- скорость восстановления после отказа.

## Наблюдаемость

Сервисы отправляют OTLP в OpenTelemetry Collector. Collector отделяет код от backend и отвечает за
batch, retry и фильтрацию. Локальный backend: Prometheus для метрик, Tempo для traces, Loki для логов и
Grafana для общего просмотра.

Минимальный trace проходит через:

```text
channel -> conversation -> agent -> approval -> action -> workflow -> mcp -> fake connector
```

В логах запрещены токены, содержимое кошелька и полный пользовательский prompt без отдельного решения.

## Безопасные chaos-тесты

Chaos Mesh включается только в namespace с явным разрешением. Начальные сценарии:

- удалить один stateless pod;
- добавить latency к PostgreSQL или Temporal;
- на короткое время вернуть ошибку fake MCP;
- остановить consumer и проверить рост/снижение lag;
- повторить событие и проверить idempotency.

Эксперименты не запускаются в production до отдельного процесса допуска.

## Quality gates pull request

- unit/integration/contract тесты зелёные;
- docs собираются в strict mode;
- нет Critical/High уязвимостей без принятого исключения;
- image имеет SBOM и подпись;
- smoke end-to-end зелёный;
- preview environment становится Healthy;
- p95 и error rate не хуже принятого baseline больше установленного допуска;
- новые публичные контракты имеют migration note.

Целевые инженерные времена: CI до 10 минут, preview environment до 15 минут, локальный быстрый запуск
до 10 минут. Сначала измеряем, затем оптимизируем.

## Почему эти инструменты

- [k3d](https://k3d.io/) — лёгкий локальный Kubernetes поверх Docker;
- [k6 Operator](https://grafana.com/docs/k6/latest/testing-guides/running-distributed-tests/) — локальные и распределённые нагрузочные тесты;
- [OpenTelemetry Collector](https://opentelemetry.io/docs/platforms/kubernetes/collector/) — vendor-neutral telemetry pipeline;
- [Argo CD ApplicationSet](https://argo-cd.readthedocs.io/en/latest/operator-manual/applicationset/) — декларативные окружения из Git;
- [OpenTofu test](https://opentofu.org/docs/cli/commands/test/) — проверяемая open-source инфраструктура;
- [Chaos Mesh](https://chaos-mesh.org/docs/) — контролируемые Kubernetes fault experiments;
- [OpenSSF Scorecard](https://openssf.org/scorecard/) — измеримый baseline безопасности open-source проекта.

Инструмент не принимается только потому, что он популярен. Он должен решить записанную проблему,
пройти trial и не дублировать уже существующий компонент.
