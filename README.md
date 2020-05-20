## Load modules, functions, aliases

* Open your PS profile, eg:
`notepad $profile.CurrentUserCurrentHost`

* Set these variables with the corresponding folder paths:
```
$PsModulesFolder = "D:\path\to\my\modules"
$GclupFolder = "C:\path\to\gclup"
```

* Import the index module:
```
Import-Module $PsModulesFolder\ModulesIndex.psm1
```
