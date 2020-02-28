function Set-SshToPersonal() {
  [CmdletBinding()]
  [Alias("ssh-personal")]
  param()

  try {
    if (-NOT [System.IO.File]::Exists("$Env:USERPROFILE\.ssh\id_rsa_personal")) {
      throw "error"
    }
    Move-Item $Env:USERPROFILE\.ssh\id_rsa $Env:USERPROFILE\.ssh\id_rsa_work -ErrorAction Stop
    Move-Item $Env:USERPROFILE\.ssh\id_rsa.pub $Env:USERPROFILE\.ssh\id_rsa.pub_work -ErrorAction Stop
    Move-Item $Env:USERPROFILE\.ssh\id_rsa_personal $Env:USERPROFILE\.ssh\id_rsa -ErrorAction Stop
    Move-Item $Env:USERPROFILE\.ssh\id_rsa.pub_personal $Env:USERPROFILE\.ssh\id_rsa.pub -ErrorAction Stop
    Write-Host "[+] Default SSH key set to personal" -ForegroundColor "green"
  }
  catch {
    Write-Host "[-] Couldn't change default SSH key" -ForegroundColor "red"
  }
}

function Set-SshToWork() {
  [CmdletBinding()]
  [Alias("ssh-work")]
  param()

  try {
    if (-NOT [System.IO.File]::Exists("$Env:USERPROFILE\.ssh\id_rsa_work")) {
      throw "error"
    }
    Move-Item $Env:USERPROFILE\.ssh\id_rsa $Env:USERPROFILE\.ssh\id_rsa_personal -ErrorAction Stop
    Move-Item $Env:USERPROFILE\.ssh\id_rsa.pub $Env:USERPROFILE\.ssh\id_rsa.pub_personal -ErrorAction Stop
    Move-Item $Env:USERPROFILE\.ssh\id_rsa_work $Env:USERPROFILE\.ssh\id_rsa -ErrorAction Stop
    Move-Item $Env:USERPROFILE\.ssh\id_rsa.pub_work $Env:USERPROFILE\.ssh\id_rsa.pub -ErrorAction Stop
    Write-Host "[+] Default SSH key set to work" -ForegroundColor "green"
  }
  catch {
    Write-Host "[-] Couldn't change default SSH key" -ForegroundColor "red"
  }
}