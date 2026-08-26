# ADR-0002: Events and durable workflows

- Status: superseded in part by ADR-0004
- Date: 2026-08-26

## Decision

Kafka carries domain and integration events. Producers use transactional outbox and consumers implement
inbox deduplication. Long-running action orchestration is delegated to Temporal as defined by ADR-0004.

HTTP is reserved for short operations that require an immediate response. Distributed database
transactions and long synchronous service chains are prohibited.

