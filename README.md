# Alexander Shvets' dotfiles for Windows

A collection of PowerShell files for Windows, including common application installation through `Chocolatey` and `npm`, and developer-minded Windows configuration defaults.

Are you a Mac user? Check out my [dotfiles](https://github.com/neochief/dotfiles) repository.

## Installation

```
powershell -Command "Start-Process PowerShell -ArgumentList ('-ExecutionPolicy RemoteSigned -Command iwr https://raw.githubusercontent.com/neochief/dotfiles-windows/master/scripts/bootstrap.ps1 -UseBasicParsing | iex') -Verb RunAs"
```