powershell -Command "Start-Process PowerShell -ArgumentList ('-ExecutionPolicy RemoteSigned -File %~dp0scripts\bootstrap.ps1') -Verb RunAs"
