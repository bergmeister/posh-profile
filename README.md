# posh-profile

[![Build status](https://ci.appveyor.com/api/projects/status/fy8d2gihiflsks3m?svg=true)](https://ci.appveyor.com/project/bergmeister/posh-profile) [![AppVeyor tests](http://flauschig.ch/batch.php?type=tests&account=bergmeister&slug=posh-profile)](https://ci.appveyor.com/project/bergmeister/posh-profile/build/tests) [![codecov](https://codecov.io/gh/bergmeister/posh-profile/branch/master/graph/badge.svg)](https://codecov.io/gh/bergmeister/posh-profile) [![PSScriptAnalyzer](https://img.shields.io/badge/Linter-PSScriptAnalyzer-blue.svg)](http://google.com) [![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

A set of Windows PowerShell functions that make day to day life easier

This is a collection of PowerShell profile helpers functions to improve efficiency.
They are focussed on 3 goals:
- Providing cmdlets for boilerplate PowerShell code that is needed for everyday tasks
- Provide short aliases to improve your PowerShell-Fu
- Provide a list of useful external modules (see [install-modules.ps1](https://github.com/bergmeister/posh-profile/blob/master/source/install-modules.ps1)) and make it faster to get started on a new machine.

If you want to get everything, then take the whole [source](https://github.com/bergmeister/posh-profile/tree/master/source) folder.
Install the 3rd party modules (required by [posh-profile.psd1](https://github.com/bergmeister/posh-profile/blob/master/source/posh-profile.psd1)) using `.\install-modules.ps1` (or modify as you wish) and import the module in your PowerShell profile as follows:
```

Import-Module 'Path\To\posh-profile.psd1' -DisableNameChecking
```
You can also just cherry pick one of self contained modules that are all in their own folder in the [source](https://github.com/bergmeister/posh-profile/tree/master/source) folder.
