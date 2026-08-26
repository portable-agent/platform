# Governance

Portable Agent starts with a maintainer-led governance model and is designed to evolve toward a small
technical steering committee as the contributor base grows.

## Roles

- Contributors submit issues, documentation, code, reviews, and operational knowledge.
- Reviewers consistently review a subsystem and may approve non-breaking changes there.
- Maintainers own releases, repository settings, security response, and project-wide decisions.

Roles are earned through sustained, constructive contribution. Access follows least privilege and may be
removed after prolonged inactivity or a Code of Conduct violation.

## Decisions

Routine changes use pull-request consensus. Architecture, security, governance, and breaking public API
decisions require an ADR and approval from at least two maintainers once the project has two maintainers.
Before then, the founding maintainer records the rationale publicly.

## Releases

Releases are reproducible from protected tags. Artifacts are built by CI, published with provenance and
SBOM, and promoted between environments by digest without rebuilding.

