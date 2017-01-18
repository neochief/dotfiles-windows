# Make vim the default editor
Set-Environment "EDITOR" "atom"
Set-Environment "GIT_EDITOR" $Env:EDITOR

# Disable the Progress Bar
$ProgressPreference='SilentlyContinue'
