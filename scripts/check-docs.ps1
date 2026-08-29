$ErrorActionPreference = "Stop"

$requiredFiles = @(
    "README.md",
    "AGENTS.md",
    "catalog-info.yaml",
    "mkdocs.yml",
    "docs/index.md",
    "docs/development.md",
    "docs/runbook.md",
    "docs/architecture/PLATFORM.md"
)

$missingFiles = $requiredFiles | Where-Object { -not (Test-Path -LiteralPath $_ -PathType Leaf) }
if ($missingFiles.Count -gt 0) {
    throw "Нет обязательных файлов: $($missingFiles -join ', ')"
}

$adrFiles = Get-ChildItem -LiteralPath "docs/adr" -Filter "*.md" -File -ErrorAction SilentlyContinue
if ($adrFiles.Count -eq 0) {
    throw "В docs/adr нужен хотя бы один ADR."
}

$agentText = Get-Content -LiteralPath "AGENTS.md" -Raw
$requiredAgentSections = @("Назначение", "Границы", "Структура", "Команды", "Правила изменений")
foreach ($section in $requiredAgentSections) {
    if ($agentText -notmatch "(?m)^## $([regex]::Escape($section))\s*$") {
        throw "В AGENTS.md нет раздела: $section"
    }
}

$catalogText = Get-Content -LiteralPath "catalog-info.yaml" -Raw
if ($catalogText -notmatch "backstage\.io/techdocs-ref:\s*dir:\.") {
    throw "В catalog-info.yaml нет backstage.io/techdocs-ref: dir:."
}
if ($catalogText -notmatch "github\.com/project-slug:\s*\S+/\S+") {
    throw "В catalog-info.yaml нет github.com/project-slug."
}

$mkdocsText = Get-Content -LiteralPath "mkdocs.yml" -Raw
if ($mkdocsText -notmatch "(?m)^docs_dir:\s*docs\s*$") {
    throw "В mkdocs.yml должен быть docs_dir: docs."
}

Write-Host "Документация соответствует базовому стандарту."
