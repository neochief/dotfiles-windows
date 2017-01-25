# Foreach subdirectory:
# 1. Run config file.
# 2. Run all reg files.

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$configRoot = Join-Path -Path $scriptDir -ChildPath sys-config

$oldLocation = Get-Location
Set-Location $configRoot

Get-ChildItem $configRoot -recurse -filter config.ps1 | Foreach-Object {
  $itemPath = $_.FullName | Resolve-Path -Relative
  echo "Running config: $itemPath"
  & $_.FullName
}

Get-ChildItem $configRoot -recurse -filter *.reg | Foreach-Object {
  $itemPath = $_.FullName | Resolve-Path -Relative
  echo "Applying patch: $itemPath"
  reg import $_.FullName >$null 2>&1
}

Set-Location $oldLocation

echo "Done. Note that some of these changes require a logout/restart to take effect."
