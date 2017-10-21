# NB Execution policy needs to be set to RemoteSigned or Unrestricted for some of them using Set-ExecutionPolicy
[CmdletBinding()]
[Diagnostics.CodeAnalysis.SuppressMessage("PSAvoidUsingInvokeExpression",'')] # Chocolatey and PoShFuck are installed using Invoke-Expression
Param()

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

Install-ModuleOnlyIfNotAlreadyInstalled posh-docker       -Scope CurrentUser -Force
Install-ModuleOnlyIfNotAlreadyInstalled posh-git          -Scope CurrentUser -Force
Install-ModuleOnlyIfNotAlreadyInstalled posh-with         -Scope CurrentUser -Force
Install-ModuleOnlyIfNotAlreadyInstalled Pester
Install-ModuleOnlyIfNotAlreadyInstalled PSScriptAnalyzer  -Scope CurrentUser -Force
Install-ModuleOnlyIfNotAlreadyInstalled Jump.Location     -Scope CurrentUser -Force

# Chocolatey: https://chocolatey.org/install
Write-Verbose 'Installing chocolatey'
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# PoShFuck a slightly vulgar typo correection helper: https://github.com/mattparkes/PoShFuck
try
{
	if ($null -eq $PROFILE)
	{
		$tempFile = [System.IO.Path]::GetTempFileName() # to an error when installing PoShFuck. Created a PR with a fix here: https://github.com/mattparkes/PoShFuck/pull/14
		$PROFILE = $tempFile
	}
	
	Write-Verbose 'Installing PoShFuck'
	Invoke-Expression ((New-Object System.Net.Webclient).DownloadString('https://raw.githubusercontent.com/mattparkes/PoShFuck/master/Install-TheFucker.ps1'))
}
finally
{
	if ($null -ne $tempFile)
	{
		Remove-Item $tempFile
	}
}
 