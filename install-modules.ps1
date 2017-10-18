# NB Execution policy needs to be set to RemoteSigned or Unrestricted for some of them using Set-ExecutionPolicy

Install-Module posh-docker -Scope CurrentUser -Force
Install-Module posh-git
Install-Module posh-with
Install-Module Pester
Install-Module PSScriptAnalyzer
Install-Module Jump-Location

# PoShFuck a slightly vulgar typo correection helper: https://github.com/mattparkes/PoShFuck
Invoke-Expression ((New-Object System.Net.Webclient).DownloadString('https://raw.githubusercontent.com/mattparkes/PoShFuck/master/Install-TheFucker.ps1'))

# Chocolatey: https://chocolatey.org/install
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
