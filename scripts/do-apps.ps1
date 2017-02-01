# Babun install
$env:HOME = $Home
$env:NOCHECK = "true"
choco install -y -r babun --allow-empty-checksums

# Browsers
choco install -y -r GoogleChrome
choco install -y -r GoogleChrome.Canary
choco install -y -r Firefox
choco install -y -r Opera

# Dev tools and frameworks
choco install -y -r atom
choco install -y -r pscx
choco install -y -r git
choco install -y -r poshgit
choco install -y -r tortoisegit
choco install -y -r python2
choco install -y -r vagrant
choco install -y -r virtualbox
vagrant plugin install vagrant-vbguest
vagrant plugin install vagrant-winnfsd


# Media
choco install -y -r itunes
choco install -y -r vlc
choco install -y -r 7zip.install

### Node Packages
if (Check-Command -cmdname "npm") {
    npm install -g babel-cli
    npm install -g grunt-cli
    npm install -g gulp
    npm install -g less
    npm install -g node-inspector
    npm install -g node-sass
    npm install -g node-gyp
}
