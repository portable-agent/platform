# Contributing

Thank you for helping build Portable Agent. Contributions of code, contracts, documentation, threat
models, evaluations, and operational runbooks are welcome.

## Development process

1. Discuss substantial product or architecture changes in an issue before implementation.
2. Create a short-lived branch from the current `main`.
3. Use Conventional Commits: `feat:`, `fix:`, `refactor:`, `test:`, `docs:`, `build:`, or `ci:`.
4. Add tests and observability with behavior changes.
5. Open a pull request and complete the operational checklist.
6. Wait for required checks and CODEOWNERS review.
7. Use squash merge; do not push directly to `main`.

## Cross-repository changes

A breaking contract change requires a compatibility plan, consumer inventory, staged rollout, and rollback.
Service repositories are released independently. Do not coordinate releases through shared snapshots or
unversioned domain libraries.

## Architecture decisions

Create an ADR when a change affects service boundaries, supported runtimes, data ownership, security
invariants, public contracts, or the operational model. An accepted ADR is changed by a superseding ADR,
not silently rewritten.

## Security and privacy

Never add credentials, personal data, production payloads, or raw user conversations to source control,
issues, tests, fixtures, or CI artifacts. Follow [SECURITY.md](SECURITY.md) for vulnerability reports.

By contributing, you agree that your contribution is licensed under Apache License 2.0 and that you will
follow the [Code of Conduct](CODE_OF_CONDUCT.md).

