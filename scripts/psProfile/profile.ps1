# Profile for the Microsoft.Powershell Shell, only. (Not Visual Studio or other PoSh instances)
# ===========

# This file can be run in non-profile context, so we should better track path on our own,
# instead of using $profile variable.
$currentRoot = Split-Path -Parent $MyInvocation.MyCommand.Path

Push-Location ($currentRoot)
"components","functions","aliases","exports","extra" | Where-Object {Test-Path "$_.ps1"} | ForEach-Object -process {Invoke-Expression ". .\$_.ps1"}
Pop-Location
