# Make vim the default editor
Set-Environment "EDITOR" "atom"
Set-Environment "GIT_EDITOR" $Env:EDITOR

Set-ItemProperty -path Registry::HKCR\batfile\shell\edit\command "(Default)" "%LOCALAPPDATA%\atom\bin\atom %1"
