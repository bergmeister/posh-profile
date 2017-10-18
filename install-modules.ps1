# NB Execution policy needs to be set to RemoteSigned or Unrestricted for some of them using Set-ExecutionPolicy

Install-Module posh-docker       -Scope CurrentUser -Force
Install-Module posh-git          -Scope CurrentUser -Force
Install-Module posh-with         -Scope CurrentUser -Force
Install-Module Pester            -Scope CurrentUser -Force
Install-Module PSScriptAnalyzer  -Scope CurrentUser -Force
Install-Module Jump-Location     -Scope CurrentUser -Force

# PoShFuck a slightly vulgar typo correection helper: https://github.com/mattparkes/PoShFuck
Write-Verbose 'Installing PoShFuck'
Invoke-Expression ((New-Object System.Net.Webclient).DownloadString('https://raw.githubusercontent.com/mattparkes/PoShFuck/master/Install-TheFucker.ps1'))

# Chocolatey: https://chocolatey.org/install
Write-Verbose 'Installing chocolatey'
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
