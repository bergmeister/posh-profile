# posh-profile [![Build status](https://ci.appveyor.com/api/projects/status/fy8d2gihiflsks3m?svg=true)](https://ci.appveyor.com/project/bergmeister/posh-profile) [![codecov](https://codecov.io/gh/bergmeister/posh-profile/branch/master/graph/badge.svg)](https://codecov.io/gh/bergmeister/posh-profile)
A set of Windows PowerShell functions that make day to day life easier

This is a collection of PowerShell profile helpers functions to improve efficiency.
They are focussed on 3 goals:
- Providing cmdlets for boilerplate PowerShell code that is needed for everyday tasks
- Provide short aliases also known as PowerShell-Fu
- Provide a list of useful external modules.

The intend is that you just import the module as:
```
Import-Module 'Path\To\posh-profile.psm1' -DisableNameChecking
```
You will then probably get some errors because you haven't installed some of the external modules that get imported. Feel free to either remove those imports or install the module by looking up the install command in `install-modules.ps1`
