$DOT = "$env:USERPROFILE\.dotfiles-windows"

#-------------------------------------------------------------------------------

function Reload-Path-Env() {
  $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
}

function Verify-Elevated {
    # Get the ID and security principal of the current user account
    $myIdentity=[System.Security.Principal.WindowsIdentity]::GetCurrent()
    $myPrincipal=new-object System.Security.Principal.WindowsPrincipal($myIdentity)
    # Check to see if we are currently running "as Administrator"
    return $myPrincipal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)
}

# Check to see if we are currently running "as Administrator"
if (!(Verify-Elevated)) {
   $newProcess = new-object System.Diagnostics.ProcessStartInfo "PowerShell";
   $newProcess.Arguments = $myInvocation.MyCommand.Definition;
   $newProcess.Verb = "runas";
   [System.Diagnostics.Process]::Start($newProcess);

   exit
}

#-------------------------------------------------------------------------------

### FIRST BOOT
cd $env:USERPROFILE
iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex
choco install -r -y git -params '"/GitAndUnixToolsOnPath /NoShellIntegration"'
Reload-Path-Env
ssh-keyscan github.com | out-file -encoding ASCII ~\.ssh\known_hosts
if (Test-Path $config) {
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

pause
