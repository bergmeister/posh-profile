# This module provides a lot of helpers for common tasks and is designed to minimize keystrokes.
# Therefore unapproved verbs are used, therefore I suggest to import the module as Import-Module 'Path\To\posh-profile.psm1' 3> $null

# ISE
Function Set-LocationToCurrentIseItem
{
	[CmdletBinding(SupportsShouldProcess=$true)] Param()

	if ($null -eq $psISE)
	{
		throw "Function only supported in PowerShell ISE"
	}
	else
	{
		$folderOfCurrentIseItem = (Split-Path $psISE.CurrentFile.FullPath -Parent)
		if ($PSCmdlet.ShouldProcess("Setting location to $($folderOfCurrentIseItem)"))
		{
			Set-Location $folderOfCurrentIseItem
		}
	}
}

# History
Function gh{(Get-History).CommandLine}
Set-Alias hh gh
Function Save-History($fileNameOrPath)
{
	if ([string]::IsNullOrEmpty($fileNameOrPath))
	{
		$fileNameOrPath = "$(Get-Date -f yyyy-MM-dd_HH-mm-ss).PowerShellHistory"
	}
	(Get-History).CommandLine | Out-File $fileNameOrPath
}

# Installed Modules
Import-Module posh-docker
Import-Module Jump.Location
Import-Module PoShFuck # Slightly vulgar Typo Correcter
Import-Module (Join-Path $PSScriptRoot "macaddressUtils.psm1")

Set-Alias f fuck
Import-Module  posh-with
Set-Alias w with

# Vim
Set-Alias vim "C:\Program Files (x86)\vim\vim80\vim.exe"
Set-Alias vi vim
Set-Alias v vim

# Dotnet Core CLI
Function dotnetclean($argument)   {dotnet clean $argument}
Function dotnetrestore($argument) {dotnet restore $argument}
Function dotnetbuild($argument)   {dotnet build $argument}
Function dotnettest($argument)    {dotnet test $argument}
Function dotnetpublish($argument) {dotnet publish $argument}
Set-Alias dnc dotnetclean
Set-Alias dnr dotnetrestore
Set-Alias dnb dotnetbuild
Set-Alias dnt dotnettest
Set-Alias dnp dotnetpublish
Set-Alias dn dotnet
Set-Alias d dotnet

# PSScriptAnalyzer
Set-Alias CA Invoke-ScriptAnalyzer
Set-Alias PSCA Invoke-ScriptAnalyzer
Set-Alias analyse Invoke-ScriptAnalyzer
Set-Alias analyse Invoke-ScriptAnalyzer
Set-Alias analyze Invoke-ScriptAnalyzer

Set-Alias tp Test-Path

Function Set-MsBuildExeVariablesForEnterpriseEdition
{
	[CmdletBinding(SupportsShouldProcess=$true)]
	[Diagnostics.CodeAnalysis.SuppressMessage("PSUseDeclaredVarsMoreThanAssignments",'')]
	[Diagnostics.CodeAnalysis.SuppressMessage("PSAvoidGlobalVars",'')]
	Param()

	$msBuildVS2015        = 'C:\Program Files (x86)\MSBuild\14.0\Bin\MSBuild.exe'
	$msBuildVS2017        = 'C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\MSBuild\15.0\Bin\MSBuild.exe'
	$msBuildVS2017Preview = 'C:\Program Files (x86)\Microsoft Visual Studio\Preview\Enterprise\MSBuild\15.0\Bin\MSBuild.exe'

	if ($PSCmdlet.ShouldProcess("Setting global MsBuild variables '$($msBuildVS2015)', '$($msBuildVS2017)' and '$(msBuildVS2017Preview)'"))
	{
		$global:msBuildVS2015        = $msBuildVS2015
		$global:msBuildVS2017        = $msBuildVS2017
		$global:msBuildVS2017Preview = $msBuildVS2017Preview
	}
}
Set-MsBuildExeVariablesForEnterpriseEdition

# uses the DOS where.exe command similar to the which command in bash
Function which
{
	[CmdletBinding()]
	[Diagnostics.CodeAnalysis.SuppressMessage("PSAvoidUsingInvokeExpression",'')]
	Param
	(
		$program
	)

	Invoke-Expression -Command "cmd.exe /C where $($program)"
}

# Explorer
Function e($argument)
{
	if([string]::IsNullOrEmpty($argument))
	{
		explorer (Get-Location)
	}
	else
	{
		explorer $argument
	}
}
Function OpenProfileInExplorer
{
	explorer (Split-Path $profile -Parent)
}

#Git
Function g($argument){git $argument}
Function GitUpdate()
{
	git pull --ff-only
	git submodule update
}
Function Update-GitRepo()
{
	[CmdletBinding(SupportsShouldProcess=$true)] Param()
	
	if ($PSCmdlet.ShouldProcess("Executing 'git pull' and 'git submodule update'"))
	{
		git pull
		git submodule update
	}
}
Set-Alias pull Update-GitRepo
Function Checkout-GitRepo
{
	[Diagnostics.CodeAnalysis.SuppressMessage("PSUseApprovedVerbs",'')]
	Param
	(
		$argument
	)

	git checkout $argument
	git submodule update
}
Set-Alias checkout Checkout-GitRepo
Function Update-GitSubmoduleRemote()
{
	[CmdletBinding(SupportsShouldProcess=$true)] Param()
	
	if ($PSCmdlet.ShouldProcess("Executing 'git submodule update --remote'"))
	{
		git submodule update --remote
	}
}
Function Update-GitSubmodule()
{
	[CmdletBinding(SupportsShouldProcess=$true)] Param()
	
	if ($PSCmdlet.ShouldProcess("Executing 'git submodule update'"))
	{
		git submodule update
	}
}
Set-Alias update Update-GitSubmodule

# GitFlow
Function New-Feature
{
	[CmdletBinding(SupportsShouldProcess=$true)]
	Param
	(
		[Parameter(Mandatory=$true)]
		$Name
	)
	
	if ($PSCmdlet.ShouldProcess("Starting new GitFlow feature $($Name) and updating submodule"))
	{
		git flow feature start $Name
		git submodule update
	}
}
Function Update-BranchFromDevelop
{
	[CmdletBinding(SupportsShouldProcess=$true)] Param()
	
	if ($PSCmdlet.ShouldProcess("Executing 'git checkout develop; git pull; git checkout -; git merge develop'"))
	{
		git checkout develop; git pull; git checkout -; git merge develop
	}
}

# Git Branching
Function CreateNewRemoteBranch($BranchName)
{
	git pull
	git checkout -b $BranchName
	git push -u origin $BranchName
}

# WSL
Function b($arguments)
{
	if($null -ne $arguments)
	{
		bash -c "$arguments"
	}
	else
	{
		bash
	}
}
Function touch($arguments){b $arguments}

# Modules
Function Reimport-Module
{
	[Diagnostics.CodeAnalysis.SuppressMessage("PSUseApprovedVerbs",'')]
	Param
	(
		$Path
	)

	if(!(Test-Path $Path))
	{
		Write-Error "Module filepath '$path' does not exist as a path."
	}
	$moduleName = (Get-Item $Path).BaseName
	Remove-Module $moduleName
	Import-Module $Path
}
New-Alias ripmo Reimport-Module
