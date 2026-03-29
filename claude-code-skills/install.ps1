$ErrorActionPreference = "Stop"

$skillsDir = "$env:USERPROFILE\.claude\skills"
$sourceDir = Join-Path $PSScriptRoot "skills"

Write-Host "Installing Claude Code skills to $skillsDir"
Write-Host ""

# Directory-based skills
$dirSkills = @("code","review","debug","bulletproof","audit","orchestrate","tokenopt","skill-optimizer","mcp-router","skill-lookup")

foreach ($skill in $dirSkills) {
    $dest = Join-Path $skillsDir $skill
    New-Item -ItemType Directory -Force -Path $dest | Out-Null
    Copy-Item (Join-Path $sourceDir "$skill.md") (Join-Path $dest "SKILL.md") -Force
    Write-Host "  Installed: $skill"
}

# Standalone skills
$standalone = @("ui-master-architect","backend-architect")

foreach ($skill in $standalone) {
    Copy-Item (Join-Path $sourceDir "$skill.md") (Join-Path $skillsDir "$skill.md") -Force
    Write-Host "  Installed: $skill"
}

Write-Host ""
Write-Host "Done. $($dirSkills.Count) directory skills + $($standalone.Count) standalone skills installed."
Write-Host ""
Write-Host "Skills are active immediately in new Claude Code sessions."
Write-Host "Invoke them with /review, /debug, /audit, /code, /bulletproof, etc."
