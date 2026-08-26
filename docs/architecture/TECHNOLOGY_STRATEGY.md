# Технологическая стратегия

Portable Agent полиглотен по замыслу, но не случайно. Набор языков ограничен Java, Python и TypeScript,
пока измеримое требование не обоснует другой runtime.

| Нагрузка | Технология | Причина |
|---|---|---|
| Транзакционное ядро | Java 25, Spring Boot 4 | Инструменты строгой согласованности, зрелая экосистема persistence и observability |
| Durable workflows | Temporal Java SDK | Долгие действия, retries, timers, approvals, compensation и replay |
| Agent runtime | Python, FastAPI, Pydantic | Сильная экосистема моделей, evaluation, retrieval и научных инструментов |
| Каналы и BFF | TypeScript, Node.js | Быстрая адаптация API и общие типы с web-клиентами |
| MCP gateway/connectors | Сначала TypeScript; Python или Java при необходимости библиотек провайдера | Tier-1 MCP-экосистема и быстрая разработка коннекторов |
| Web и Widget SDK | TypeScript, React | Переносимые типизированные UI-контракты и знакомый стек |
| Policy decisions | Open Policy Agent, Rego | Проверяемый policy-as-code отдельно от application code |
| Identity | Keycloak, OIDC/OAuth 2.1 | Стандартная self-hosted идентификация и federation |
| Events | Kafka | Durable integration events, replay, fan-out и поддержка экосистемы |
| Data | PostgreSQL на сервис; Redis для ephemeral state | Явное владение и зрелость эксплуатации |
| Telemetry | OpenTelemetry, Prometheus, Grafana, Loki, Tempo | Независимые от вендора metrics, logs и traces |
| Delivery | OCI, Kubernetes, Helm, Argo CD, External Secrets | Воспроизводимые образы и GitOps-развёртывание |

## Чего мы намеренно избегаем

- Отдельного языка для каждого сервиса.
- Общих библиотек доменных моделей между репозиториями.
- Самописного workflow engine на Kafka consumers и колонках статуса в базе.
- Kubernetes до того, как локальные контейнеры и контракты станут надёжными.
- Backstage как runtime-зависимости: это только портал разработчика и projection каталога.
- Новой инфраструктуры без владельца, runbook, health signal и описанного failure mode.
