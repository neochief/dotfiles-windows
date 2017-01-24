###############################################################################
### PowerShell Profile
###############################################################################

# Profile is linked from psProfile directory to Documents/WindowsPowerShell
# Existing profile is backed-up at Documents/WindowsPowerShell_bak.

$profileDir = Split-Path -parent $profile
if ([System.IO.Directory]::Exists($profileDir)) {
  $info = Get-Item $profileDir -Force -ea 0
  $isLink = [bool]($info.Attributes -band [IO.FileAttributes]::ReparsePoint)
  if ($isLink) {
    Remove-Item $profileDir -Force
  }
  else {
    Remove-Item "$($profileDir)_bak" -Force
    Rename-Item $profileDir "$($profileDir)_bak"
  }
}

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$psProfile = Join-Path -Path $scriptDir -ChildPath psProfile
New-Item -ItemType SymbolicLink -Path $(Split-Path -parent $profileDir) -Name WindowsPowerShell -Value $psProfile
