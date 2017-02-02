# You can export your current power settings with following commands:
# powercfg /GETACTIVESCHEME
# powercfg -export $env:UserProfile/.dotfiles-windows/scripts/sys-config/power/PowerConfig.pow {GUID}


$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$script  = Join-Path -Path $scriptDir -ChildPath PowerConfig.pow
$importOutput = powercfg -import $script
$foundGUID = $importOutput -match 'GUID: ([^ ]+)$'
if ($foundGUID) {
  $GUID = $matches[1]
  powercfg /setactive $GUID
  powercfg /changename $GUID ".dotfiles power config"
}

powercfg /L | select-string -pattern ".dotfiles power config\)$" | Where-Object {$_ -match "Power Scheme GUID: ([^ ]+)  "} | Foreach { powercfg /delete $matches[1]}
