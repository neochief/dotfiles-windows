# Register global dotfiles location.
[Environment]::SetEnvironmentVariable("dot", "$env:USERPROFILE\.dotfiles-windows", "User")

# Disable the Progress Bar
$ProgressPreference='SilentlyContinue'
