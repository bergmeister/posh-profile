# NB Execution policy needs to be set to RemoteSigned or Unrestricted for some of them using Set-ExecutionPolicy
 [CmdletBinding()]Param()
 
Function Install-ModuleOnlyIfNotAlreadyInstalled($ModuleName)
{
    if (-not (Get-Module -ListAvailable $ModuleName))
    {
        Write-Verbose "Installing Module $($ModuleName)"
        Install-Module $ModuleName -Scope CurrentUser -Force
    }
    else
    {
        Write-Verbose "Module $($ModuleName) is already installed"
    }
}
 
Install-Module posh-docker       -Scope CurrentUser -Force
Install-Module posh-git          -Scope CurrentUser -Force
Install-Module posh-with         -Scope CurrentUser -Force
Install-ModuleOnlyIfNotAlreadyInstalled Pester
Install-Module PSScriptAnalyzer  -Scope CurrentUser -Force
Install-Module Jump.Location     -Scope CurrentUser -Force

# PoShFuck a slightly vulgar typo correection helper: https://github.com/mattparkes/PoShFuck
Write-Verbose 'Installing PoShFuck'
Invoke-Expression ((New-Object System.Net.Webclient).DownloadString('https://raw.githubusercontent.com/mattparkes/PoShFuck/master/Install-TheFucker.ps1'))

# Chocolatey: https://chocolatey.org/install
Write-Verbose 'Installing chocolatey'
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
