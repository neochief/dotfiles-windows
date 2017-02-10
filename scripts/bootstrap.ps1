# TODO:
# 1. Editor env variable.
# 2. Atom editor for all text files.
# 3. Default PHPStorm config.
# 4. Link .atom to home
# 5. https://www.tenforums.com/tutorials/8744-default-app-associations-export-import-new-users-windows.html
# 6. Recheck web install from readme.
# 7. Extract neochief credentials.
# 8. Homestead?
# 9. TortoiseGit settings?

function Check-Command($cmdname) {
    return [bool](Get-Command -Name $cmdname -ErrorAction SilentlyContinue)
}

function Verify-Elevated {
    # Get the ID and security principal of the current user account
    $myIdentity=[System.Security.Principal.WindowsIdentity]::GetCurrent()
    $myPrincipal=new-object System.Security.Principal.WindowsPrincipal($myIdentity)
    # Check to see if we are currently running "as Administrator"
    return $myPrincipal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)
}

if (! (Verify-Elevated)) {
  echo "THIS SCRIPT SHOULD BE RUN AS ADMINISTRATOR."
  pause
  exit
}

#-------------------------------------------------------------------------------

[Environment]::SetEnvironmentVariable("dot", "$env:USERPROFILE\.dotfiles-windows", "User")

#-------------------------------------------------------------------------------

### Install chocolatey and git at first boot.
cd $env:USERPROFILE

if (!(Check-Command -cmdname "choco")) {
  echo ""
  echo "INSTALLING PACKAGE MANAGE"
  iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex
}

if (!(Check-Command -cmdname "git")) {
  echo ""
  echo "INSTALLING GIT"
  choco install -r -y git -params '"/GitAndUnixToolsOnPath /NoShellIntegration"'
  Refresh-Environment
}

New-Item -ItemType Directory -Force -Path ~\.ssh
ssh-keyscan github.com | out-file -encoding ASCII ~\.ssh\known_hosts

if (Test-Path $env:dot) {   
  echo ""
  echo "UPDATING .DOTFILES"

  cd $env:dot
  git pull --rebase
}
else {
  echo ""
  echo "PULLING .DOTFILES"

  git clone https://github.com/neochief/dotfiles-windows.git $env:dot
}

. $env:dot\scripts\psProfile\profile.ps1


### Link PowerShell profile
echo ""
echo "Working on PROFILE"
. $env:dot/scripts/do-ps-profile.ps1

### Link home directory files
echo ""
echo "Working on HOME"
. $env:dot/scripts/do-home.ps1

### Installs
echo ""
echo "Working on INSTALLS"
. $env:dot/scripts/do-apps.ps1

### System config
echo ""
echo "Working on SYSTEM CONFIGURATION"
. $env:dot/scripts/do-sys-config.ps1

sudo
