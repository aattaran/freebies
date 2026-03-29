$ErrorActionPreference = "Stop"

$claudeDir = "$env:USERPROFILE\.claude"
$sourceDir = $PSScriptRoot

Write-Host "Installing Fleet Commander to $claudeDir"
Write-Host ""

# Skills
New-Item -ItemType Directory -Force -Path "$claudeDir\skills\fleet-commander" | Out-Null
Copy-Item "$sourceDir\skills\fleet-commander\SKILL.md" "$claudeDir\skills\fleet-commander\SKILL.md" -Force
Write-Host "  Installed: fleet-commander skill"

New-Item -ItemType Directory -Force -Path "$claudeDir\skills\fleet-review" | Out-Null
Copy-Item "$sourceDir\skills\fleet-review\SKILL.md" "$claudeDir\skills\fleet-review\SKILL.md" -Force
Write-Host "  Installed: fleet-review skill"

# Agent definitions
New-Item -ItemType Directory -Force -Path "$claudeDir\agents" | Out-Null
Get-ChildItem "$sourceDir\agents\*.md" | ForEach-Object {
    Copy-Item $_.FullName "$claudeDir\agents\$($_.Name)" -Force
    Write-Host "  Installed: agent $($_.BaseName)"
}

# Commands
New-Item -ItemType Directory -Force -Path "$claudeDir\commands" | Out-Null
Get-ChildItem "$sourceDir\commands\*.md" | ForEach-Object {
    Copy-Item $_.FullName "$claudeDir\commands\$($_.Name)" -Force
    Write-Host "  Installed: command $($_.BaseName)"
}

Write-Host ""
Write-Host "Done. Fleet Commander is ready."
Write-Host ""
Write-Host "Try: 'Deploy 4 agents to implement feature X'"
Write-Host "Or:  'Use fleet-commander to set up a team'"
