# This module provides a lot of helpers for common tasks and is designed to minimize keystrokes.
# Therefore unapproved verbs are used, therefore I suggest to import the module as Import-Module 'Path\To\posh-profile.psm1' 3> $null

# ISE
Function Set-LocationToCurrentIseItem
{
	if($null -eq $psISE)
	{
		Write-Error "Function only supported in PowerShell ISE"
	}
	else
	{
		Set-Location (Split-Path $psISE.CurrentFile.FullPath -Parent)
	}
}

# History
Function gh{(Get-History).CommandLine}
Set-Alias hh gh
Function Save-History($fileNameOrPath)
{
	if([string]::IsNullOrEmpty($fileNameOrPath))
	{
		$fileNameOrPath = "$(Get-Date -f yyyy-MM-dd_HH-mm-ss).PowerShellHistory"
	}
	(Get-History).CommandLine | Out-File $fileNameOrPath
}

# Installed Modules
Import-Module posh-docker
Import-Module Jump.Location
Import-Module PoShFuck # Slightly vulgar Typo Correcter
Import-Module ("module_macaddress.psm1")

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

$msBuildVS2015        = 'C:\Program Files (x86)\MSBuild\14.0\Bin\MSBuild.exe'
$msBuildVS2017        = 'C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\MSBuild\15.0\Bin\MSBuild.exe'
$msBuildVS2017Preview = 'C:\Program Files (x86)\Microsoft Visual Studio\Preview\Enterprise\MSBuild\15.0\Bin\MSBuild.exe'

# uses the DOS where.exe command similar to the which command in bash
Function which($program)
{
	Invoke-Expression -Command "cmd.exe /C where $program"
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
	git pull
	git submodule update
}
Set-Alias pull Update-GitRepo
Function Checkout-GitRepo($argument)
{
	git checkout $argument
	git submodule update
}
Set-Alias checkout Checkout-GitRepo
Function Update-GitSubmoduleRemote()
{
	git submodule update --remote
}
Function Update-GitSumodule(){ git submodule update}
Set-Alias update Update-GitSumodule

# GitFlow
Function New-Feature($name)
{
	git flow feature start $name
	git submodule update
}
Function Upstream-BranchFromDevelop
{
	git checkout develop; git pull; git checkout -; git merge develop
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
Function Reimport-Module([string] $path)
{
	if(!(Test-Path $path))
	{
		Write-Error "Module filepath '$path' does not exist as a path."
	}
	$moduleName = (Get-Item $path).BaseName
	rmo  $moduleName
	ipmo $path
}
New-Alias ripmo Reimport-Module
