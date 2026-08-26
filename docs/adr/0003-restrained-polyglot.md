# ADR-0003: Restrained polyglot architecture

- Status: accepted
- Date: 2026-08-26

## Context

The platform contains transactional workflows, AI inference, channel adapters, MCP integrations, and a
portable web UI. A single language would simplify staffing but would push important workloads away from
their strongest ecosystems. Unrestricted polyglot architecture would multiply operational cost.

## Decision

Support three application runtimes:

- Java for transactional domain services and Temporal workflows.
- Python for the agent runtime, model evaluation, and retrieval.
- TypeScript for channels, MCP integrations, BFFs, and widget/web code.

Rego is accepted as policy language and is not considered an application runtime. A fourth application
language requires an ADR with benchmarks, ownership, CI template, observability support, and maintenance
commitment.

## Consequences

Services use native ecosystems without turning the platform into a language zoo. Platform engineering
must maintain three golden-path templates and reusable pipelines.

