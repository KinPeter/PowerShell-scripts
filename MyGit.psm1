function Get-BranchByIssue {
  [CmdletBinding()]
  [Alias("mygit-co")]
  param(
    [Parameter(Mandatory=$true)][string]$issueNumber
  )

  $branches = git branch -a
  $foundBranches = $branches | Select-String -Pattern $issueNumber

  if ($foundBranches.length -lt 1) {
    Write-Host "No such branch found."
    return 
  } elseif ($foundBranches.length -gt 1) {
    $path = $foundBranches[0].ToString().trim()
  } else {
    $remoteOnly = $foundBranches[0] -Match "remotes/origin"
    if ($remoteOnly) {
      $pathSplitted = $foundBranches[0] -split "/"
      $path = $pathSplitted[2] + "/" + $pathSplitted[3]
    } else {
      $path = $foundBranches[0].ToString().trim()
    }
  }

  git checkout $path
  git pull origin $path
}

function Clear-Branches {
  [CmdletBinding(DefaultParameterSetName = "Normal")]
  [Alias("mygit-clup")]
  param(
    [parameter(ParameterSetName = "Normal")]
    [Alias("n")]
    [switch]
    $normal,
    
    [parameter(ParameterSetName = "Soft")]
    [Alias("s")]
    [switch]
    $soft,

    [parameter(ParameterSetName = "Forced")]
    [Alias("f")]
    [switch]
    $forced
  )

  if ( -Not $normal -and -Not $soft -and -Not $forced ) {
    $normal = $true
  }

  $gitBranch = git branch
  [string[]]$branches = @()
  foreach($line in $gitBranch) {
    if ($line.ToString().StartsWith("*") -or ($line.ToString().trim() -eq "master") -or ($line.ToString().trim() -eq "develop")) { continue }
    $branches += $line.ToString().trim()
  }

  if ($soft) {
    Write-Host "[+] Starting in SOFT mode..."
    foreach ($branch in $branches) {
      $response = git branch -d $branch 2>&1
      if ($response -Match "not fully merged") {
        Write-Host "[Kept branch] $branch"
      } else {
        Write-Host "[Deleted branch] $branch"
      }
    }  
  }

  if ($forced) {
    Write-Host "[+] Starting in FORCED mode..."
    foreach ($branch in $branches) {
      $response = git branch -D $branch 
      Write-Host "[Deleted branch] $branch"      
    }  
  }

  if ($normal) {
    Write-Host "[+] Starting in NORMAL mode..."
    foreach ($branch in $branches) {
      $response = git branch -d $branch 2>&1
      if ($response -Match "not fully merged") {
        Write-Host "[-] Could not delete $branch"
        $answer = Read-Host "[?] Do you want to force delete it? (Y/n)"
        if ($answer -eq "N" -or $answer -eq "n") {
          Write-Host "[Kept branch] $branch"
        } else {
          $response = git branch -D $branch 
          Write-Host "[Deleted branch] $branch"
        }
      }
      else {
        Write-Host "[Deleted branch] $branch"
      }
    }  
  }
}