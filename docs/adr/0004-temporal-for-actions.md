# ADR-0004: Temporal for durable action execution

- Status: accepted
- Date: 2026-08-26

## Context

Actions can wait for user approval, provider recovery, scheduled time, or compensation. Implementing these
semantics with Kafka consumers and database status fields would create a custom workflow engine.

## Decision

Action Service owns Temporal workflows. Kafka remains the integration-event backbone and is not used as a
substitute for workflow state. Workflow code must be deterministic; provider calls run as Activities.

## Consequences

The platform gains durable timers, retries, cancellation, versioning, visibility, and replay. Temporal
becomes operational infrastructure and therefore requires backup, monitoring, upgrade, and runbook work.

