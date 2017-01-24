# Foreach subdirectory:
# 1. Run config file.
# 2. Run all reg files.

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$configRoot = Join-Path -Path $scriptDir -ChildPath sys-config | dir

foreach ($configDir in $configRoot) {
  $config = Join-Path -Path $configDir.FullName -ChildPath config.ps1
  $exists = Test-Path $config
  if ($exists) {
     echo "Running config: '$($configDir.Name)/config.ps1'"
     & $config
  }

  $registryPatches = Join-Path -Path $configDir.FullName -ChildPath *.reg
  Get-ChildItem $registryPatches -Filter *.reg | Foreach-Object {
      echo "Applying patch: '$($configDir.Name)/$($_.Name)'"
      reg import $_.FullName >$null 2>&1
  }
}

echo "Done. Note that some of these changes require a logout/restart to take effect."
