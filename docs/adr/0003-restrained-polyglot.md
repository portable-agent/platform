# ADR-0003: Ограниченная полиглотная архитектура

- Status: accepted
- Date: 2026-08-26

## Контекст

Платформа включает транзакционные workflows, AI inference, адаптеры каналов, MCP-интеграции и переносимый
web UI. Один язык упростил бы подбор команды, но отдалил бы важные нагрузки от сильнейших экосистем.
Неограниченная полиглотность увеличила бы операционные расходы.

## Решение

Поддерживать три application runtime:

- Java for transactional domain services and Temporal workflows.
- Python for the agent runtime, model evaluation, and retrieval.
- TypeScript for channels, MCP integrations, BFFs, and widget/web code.

Rego принят как policy language и не считается application runtime. Для четвёртого языка требуется ADR с
benchmarks, владельцем, CI-шаблоном, поддержкой observability и обязательством по сопровождению.

## Последствия

Сервисы используют нативные экосистемы без превращения платформы в языковой зоопарк. Platform engineering
поддерживает три golden-path templates и переиспользуемые pipelines.
