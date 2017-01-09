# Update Help for Modules
Update-Help -Force

### Package Providers
Get-PackageProvider NuGet -Force
# Chocolatey Provider is not ready yet. Use normal Chocolatey
#Get-PackageProvider Chocolatey -Force
#Set-PackageSource -Name chocolatey -Trusted

### Chocolatey
if ((which cinst) -eq $null) {
    iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))
    Refresh-Environment
    choco feature enable -n=allowGlobalConfirmation
}

# system and cli
#cinst curl #`curl` comes with GH4W
cinst nuget.commandline
cinst webpi
cinst wget
cinst wput

# browsers
cinst GoogleChrome
cinst GoogleChrome.Canary
cinst Firefox
cinst Opera

# dev tools and frameworks
cinst atom
cinst hg
cinst Fiddler4
cinst nodejs.install
cinst ruby
cinst babun

# other
#cinst wincommandpaste # Copy/Paste is supported natively in Win10

### Node Packages
if (which npm) {
    npm install -g babel-cli
    npm install -g grunt-cli
    npm install -g gulp
    npm install -g less
    npm install -g node-inspector
    npm install -g node-sass
}
