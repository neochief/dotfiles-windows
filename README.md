# Jay Harris's dotfiles for Windows

A collection of PowerShell files for Windows, including common application installation through `Chocolatey` and `npm`, and developer-minded Windows configuration defaults.

Are you a Mac user? Check out my [dotfiles](https://github.com/neochief/dotfiles) repository.

## Installation

### Using Git and the bootstrap script

You can clone the repository wherever you want. (I like to keep it in `~\.dotfiles-windows`.)

The bootstrapper script will copy the files to your PowerShell Profile folder.

From PowerShell:
```posh
git clone https://github.com/neochief/dotfiles-windows.git ~/.dotfiles-windows
cd ~/.dotfiles-windows
Set-ExecutionPolicy Unrestricted
. .\bootstrap.ps1
```

To update your settings, `cd` into your local `dotfiles-windows` repository within PowerShell and then:

```posh
. .\bootstrap.ps1
```

### Git-free install

To install these dotfiles from PowerShell without Git:

```bash
Set-ExecutionPolicy Unrestricted
iex ((new-object net.webclient).DownloadString('https://raw.github.com/neochief/dotfiles-windows/master/setup/install.ps1'))
```

To update later on, just run that command again.

### Install dependencies and packages

When setting up a new Windows box, you may want to install some common packages, utilities, and dependencies. These could include node.js packages via [NPM](https://www.npmjs.org), [Chocolatey](http://chocolatey.org/) packages, Windows Features and Tools via [Web Platform Installer](https://www.microsoft.com/web/downloads/platform.aspx), and Visual Studio Extensions from the [Visual Studio Gallery](http://visualstudiogallery.msdn.microsoft.com/).

```posh
.\deps.ps1
```

> The scripts will install Chocolatey, node.js, and WebPI if necessary.

> **Visual Studio Extensions**  
> Extensions will be installed into your most current version of Visual Studio. You can also install additional plugins at any time via `Install-VSExtension $url`. The Url can be found on the gallery; it's the extension's `Download` link url.


### PHPStorm and Babun

In order to get Babun shell as a terminal in PHPStom, go into File > Settings > Tools > Terminal and put the path to "babun-embed.bat" into the "Shell path" field.


### Sensible Windows defaults

When setting up a new Windows PC, you may want to set some Windows defaults and features, such as showing hidden files in Windows Explorer and installing IIS. This will also set your machine name and full user name, so you may want to modify this file before executing.

```post
.\windows.ps1
```
