###############################################################################
### PowerShell Profile
###############################################################################

# Profile is linked from psProfile directory to Documents/WindowsPowerShell
# Existing profile is backed-up at Documents/WindowsPowerShell_bak.

$profileDir = Split-Path -parent $profile
if (Exists $profileDir) {
  if (Is-Link $profileDir) {
    [IO.Directory]::Delete($profileDir)
  }
  else {
    echo "Linked new PowerShell profile. Existing PowerShell profile has been moved to $($profileDir)_bak."
    Remove-Item "$($profileDir)_bak" -Recurse -ErrorAction Ignore
    Rename-Item $profileDir "$($profileDir)_bak"
  }
}
else {
  echo "Linked new PowerShell profile."
}

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$psProfile = Join-Path -Path $scriptDir -ChildPath psProfile
New-Item -ItemType SymbolicLink -Path $(Split-Path -parent $profileDir) -Name WindowsPowerShell -Value $psProfile | Out-Null
