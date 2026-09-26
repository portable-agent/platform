$ErrorActionPreference = "Stop"

$requiredFiles = @(
    "README.md",
    "AGENTS.md",
    "catalog-info.yaml",
    "mkdocs.yml",
    "docs/index.md",
    "docs/development.md",
    "docs/runbook.md",
    "docs/architecture/PLATFORM.md",
    "docs/adr/0015-google-calendar-connection.md"
)

$missingFiles = $requiredFiles | Where-Object { -not (Test-Path -LiteralPath $_ -PathType Leaf) }
if ($missingFiles.Count -gt 0) {
    throw "Required files are missing: $($missingFiles -join ', ')"
}

$adrFiles = Get-ChildItem -LiteralPath "docs/adr" -Filter "*.md" -File -ErrorAction SilentlyContinue
if ($adrFiles.Count -eq 0) {
    throw "docs/adr must contain at least one ADR."
}

$agentText = Get-Content -LiteralPath "AGENTS.md" -Raw
$agentSections = [regex]::Matches($agentText, "(?m)^##\s+\S.*$")
if ($agentSections.Count -lt 5) {
    throw "AGENTS.md must contain at least five rule sections."
}

$catalogText = Get-Content -LiteralPath "catalog-info.yaml" -Raw
if ($catalogText -notmatch "backstage\.io/techdocs-ref:\s*dir:\.") {
    throw "catalog-info.yaml has no backstage.io/techdocs-ref: dir:."
}
if ($catalogText -notmatch "github\.com/project-slug:\s*\S+/\S+") {
    throw "catalog-info.yaml has no github.com/project-slug."
}

$mkdocsText = Get-Content -LiteralPath "mkdocs.yml" -Raw
if ($mkdocsText -notmatch "(?m)^docs_dir:\s*docs\s*$") {
    throw "mkdocs.yml must contain docs_dir: docs."
}

$googleAdr = Get-Content -LiteralPath "docs/adr/0015-google-calendar-connection.md" -Raw
foreach ($required in @(
    "connection-service",
    "Authorization Code",
    "refresh token",
    "actorId",
    "calendar.events",
    "base32hex",
    "fake-calendar"
)) {
    if ($googleAdr -notmatch [regex]::Escape($required)) {
        throw "Google Calendar ADR does not contain $required."
    }
}

Write-Host "Documentation follows the project standard."
