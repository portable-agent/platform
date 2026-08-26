# ADR-0001: Independent service repositories

- Status: accepted
- Date: 2026-08-26

## Decision

Use a polyrepo model. The platform control plane and every deployable service have separate repositories,
independent versioning, ownership, and delivery pipelines. Cross-service contracts are also promoted to a
dedicated repository when the GitHub Organization is created. Organization reusable workflows provide
consistent CI without compiling repositories together.

Shared Java or TypeScript packages are allowed only for technical concerns. Domain models are not shared
as libraries; service boundaries are versioned API and event contracts.

## Consequences

Teams practice independent releases, ownership, and contract testing. The platform must automate
repository creation, policy enforcement, dependency updates, and golden-path templates.
