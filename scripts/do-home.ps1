###############################################################################
### Home directory files
###############################################################################

# Meta configuration such as .gitconfig, .bashrc, .npmrc is stored in homeFiles
# directory. We link these files from .dotfiles directory to keep them under
# version control.

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$homeInDotFiles = Join-Path -Path $scriptDir -ChildPath home | dir

foreach ($homeItem in $homeInDotFiles) {

  $itemInRealHome = Join-Path -Path $home -ChildPath $homeItem.Name

  if (Exists $itemInRealHome) {
    if (Is-Link $itemInRealHome) {
      if (Is-Dir $itemInRealHome) {
        [IO.Directory]::Delete($profileDir)
      }
      else {
        Remove-Item $itemInRealHome
      }
    }
    else {
      echo "Linked ~\$($homeItem.Name). Old item moved to ~\$($homeItem.Name)_bak"
      Remove-Item "$($itemInRealHome)_bak" -Recurse -ErrorAction Ignore
      Rename-Item $itemInRealHome "$($itemInRealHome)_bak"
    }
  }
  else {
    echo "Linked ~\$($homeItem.Name)"
  }

  New-Item -ItemType SymbolicLink -Path $home -Name $homeItem.Name -Value $homeItem.FullName | Out-Null
}
