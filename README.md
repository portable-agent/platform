# Portable Agent Platform

An open-source platform for a portable personal AI agent. A user expresses an intent by voice or text,
reviews a deterministic action in a channel-independent widget, and safely executes it through MCP tools.

This is a standalone product. It is not related to the existing `planner` repository.

[Русская версия](README.ru.md)

## Repository role

This repository is the platform control plane: architecture, cross-service contracts, service catalog,
developer documentation, GitOps configuration, and organization-wide engineering standards. Every
deployable service lives in its own GitHub repository, owns its data, and has an independent pipeline.

It is deliberately not a monorepo and does not contain service implementation modules.

## First vertical slice

```text
Telegram voice -> STT -> Conversation -> Agent -> Proposed action
               -> Policy -> Confirmation widget -> Durable workflow
               -> MCP Gateway -> Calendar -> Result + audit trail
```

## Architecture

- [Platform architecture](docs/architecture/PLATFORM.md)
- [Action execution sequence](docs/architecture/ACTION_EXECUTION.md)
- [Technology strategy](docs/architecture/TECHNOLOGY_STRATEGY.md)
- [Repository and organization model](docs/architecture/REPOSITORY_MODEL.md)
- [Service catalog](catalog/services.yaml)
- [Delivery roadmap](docs/delivery/ROADMAP.md)
- [Architecture decision records](docs/adr/)

## Open-source project

Portable Agent Platform is licensed under Apache License 2.0. Read the
[contribution guide](CONTRIBUTING.md), [governance model](GOVERNANCE.md),
[code of conduct](CODE_OF_CONDUCT.md), and [security policy](SECURITY.md) before contributing.
