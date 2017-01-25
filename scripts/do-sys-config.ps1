###############################################################################
### System Configuration
###############################################################################

# This script will recursively scan sys-config directory for config.ps1
# and *.reg files and execute them.

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

# Restart explorer
taskkill /IM explorer.exe /F  >$null 2>&1
explorer.exe

echo ""
echo "Done. Note that some of these changes may require a logout/restart to take effect."
