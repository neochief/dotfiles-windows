# Alexander Shvets' dotfiles for Windows

A collection of PowerShell files for Windows, including common application installation through `Chocolatey` and `npm`, and developer-minded Windows configuration defaults.

Are you a Mac user? Check out my [dotfiles](https://github.com/neochief/dotfiles) repository.

## Installation

1. Press Cmd+R and run this:
```
powershell -Command "Start-Process PowerShell -ArgumentList ('-ExecutionPolicy RemoteSigned') -Verb RunAs"
```

2. Copy following to PowerShell:
```
cd ~
iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex
$env:HOME = $Home
$env:NOCHECK = "true"
choco install babun -y --allow-empty-checksums
choco install git -y -params '"/GitAndUnixToolsOnPath /NoShellIntegration"'
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
ssh-keyscan github.com | out-file -encoding ASCII ~\.ssh\known_hosts
git clone git@github.com:neochief/dotfiles-windows.git .dotfiles-windows
cd .dotfiles-windows
. ./bootstrap.ps1
```
