# ADR-0002: События и durable workflows

- Status: superseded in part by ADR-0004
- Date: 2026-08-26

## Решение

Kafka переносит domain и integration events. Producers используют transactional outbox, а consumers —
inbox deduplication. Долгая оркестрация действий передаётся Temporal согласно ADR-0004.

HTTP предназначен для коротких операций с немедленным ответом. Распределённые транзакции базы данных и
длинные синхронные цепочки сервисов запрещены.
