function Get-BranchByIssue {
  [cmdletbinding()]
  [alias("cobr")]
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