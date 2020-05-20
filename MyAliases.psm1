function Open-PowershellProfile { code $profile.CurrentUserCurrentHost }
Set-Alias -Name open-profile -Value Open-PowershellProfile

function Use-NodeVersion10 { nvm use 10.20.1 }
Set-Alias -Name "nvm-10" -Value Use-NodeVersion10

function Use-NodeVersion12 { nvm use 12.16.3 }
Set-Alias -Name "nvm-12" -Value Use-NodeVersion12

# function Start-GitCleanup { node C:\Users\kinpe\code\gclup\index.js -p $(Get-Location) }
function Start-GitCleanup { node $GclupFolder\index.js -p $(Get-Location) }
Set-Alias -Name git-clean -Value Start-GitCleanup