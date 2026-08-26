# Security policy

## Reporting

Do not disclose vulnerabilities, credentials, personal data, or exploitable details in public issues.
Use GitHub Private Vulnerability Reporting for the affected repository. If that channel is unavailable,
open a public issue containing no sensitive details and ask a maintainer for a private contact channel.

Include the affected component and version, impact, reproduction steps, prerequisites, and suggested
mitigation. Receipt should be acknowledged within 72 hours. Public disclosure is coordinated after a fix
and affected-user guidance are available.

## Supported versions

The latest release and the current default branch are supported until a formal support matrix is published.

## Security invariants

- Secrets live in a secret manager and never in Git, CI logs, events, or images.
- High-risk actions require immutable payload approval and step-up authentication.
- Providers receive the minimum OAuth scopes needed for an action.
- Every changing operation is attributable, idempotent, and auditable.
- Production images are built in CI, scanned, accompanied by an SBOM, and identified by digest.

