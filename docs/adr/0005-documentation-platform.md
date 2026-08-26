# ADR-0005: Public docs and developer portal

- Status: accepted
- Date: 2026-08-26

## Decision

Use Docusaurus and Mermaid for the public, versioned, open-source documentation site deployed through
GitHub Pages. Keep documentation as Markdown beside architecture and contracts.

Adopt Backstage Catalog and TechDocs after the first service repositories exist. Each service will own a
root `catalog-info.yaml` and docs directory. Backstage is a projection for discovery and templates, not the
source of truth; Git repositories remain authoritative.

## Consequences

External contributors get a lightweight public portal immediately. The team can later add an internal
service catalog and golden-path scaffolder without migrating the documentation model.

