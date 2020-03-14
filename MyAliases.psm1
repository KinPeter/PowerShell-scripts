function Open-PowershellProfile { code C:\Windows\System32\WindowsPowerShell\v1.0\Profile.ps1 }
Set-Alias -Name open-profile -Value Open-PowershellProfile

function Use-NodeVersion10 { nvm use 10.19.0 }
Set-Alias -Name "nvm-10" -Value Use-NodeVersion10

function Use-NodeVersion12 { nvm use 12.16.1 }
Set-Alias -Name "nvm-12" -Value Use-NodeVersion12
