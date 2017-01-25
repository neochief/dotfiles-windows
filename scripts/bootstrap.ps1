# TODO:
# 1. Editor env variable.
# 2. Atom editor for all text files.
# 3. Default PHPStorm config.
# 4. Link .atom to home
# 5. https://www.tenforums.com/tutorials/8744-default-app-associations-export-import-new-users-windows.html
# 6. Recheck web install from readme.
# 7. Extract neochief credentials.
# 8. Homestead?




$DOT = "$env:USERPROFILE\.dotfiles-windows"

#-------------------------------------------------------------------------------

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
& "$scriptDir\psProfile\profile.ps1"

# Check to see if we are currently running "as Administrator"
if (!(Verify-Elevated)) {
   $newProcess = new-object System.Diagnostics.ProcessStartInfo "PowerShell";
   $newProcess.Arguments = $myInvocation.MyCommand.Definition;
   $newProcess.Verb = "runas";
   [System.Diagnostics.Process]::Start($newProcess);
   exit
}

#-------------------------------------------------------------------------------

### Install chocolatey and git at first boot.
cd $env:USERPROFILE

if (!(Check-Command -cmdname "choco")) {
  iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex
}

if (!(Check-Command -cmdname "git")) {
  choco install -r -y git -params '"/GitAndUnixToolsOnPath /NoShellIntegration"'
  Refresh-Environment
}

ssh-keyscan github.com | out-file -encoding ASCII ~\.ssh\known_hosts

if (Test-Path $DOT) {
 cd $DOT
 git stash
 git pull --rebase
 git stash apply
}
else {
  git clone git@github.com:neochief/dotfiles-windows.git $DOT
}


### Link PowerShell profile
. $DOT/scripts/do-ps-profile.ps1

### Link home directory files
. $DOT/scripts/do-home.ps1

### Installs
. $DOT/scripts/do-apps.ps1

### System config
. $DOT/scripts/do-sys-config.ps1

sudo
