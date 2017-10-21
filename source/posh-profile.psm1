# This module provides a lot of helpers for common tasks and is designed to minimize keystrokes.
# Therefore unapproved verbs are used, therefore I suggest to import the module as Import-Module 'Path\To\posh-profile.psd1' 3> $null

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
Function Save-History($fileNameOrPath)
{
	if ([string]::IsNullOrEmpty($fileNameOrPath))
	{
		$fileNameOrPath = "$(Get-Date -f yyyy-MM-dd_HH-mm-ss).PowerShellHistory"
	}
	(Get-History).CommandLine | Out-File $fileNameOrPath
}

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

# WSL
Function b($arguments)
{
	if ($null -ne $arguments)
	{
		bash -c "$arguments"
	}
	else
	{
		bash
	}
}

Function touch($arguments){New-Item -ItemType File -Name $arguments}

# Modules
Function ReImport-Module
{
	[Diagnostics.CodeAnalysis.SuppressMessage("PSUseApprovedVerbs",'')]
	Param
	(
		$Path
	)

	if (!(Test-Path $Path))
	{
		throw "Module filepath '$Path' does not exist as a path."
	}

	$moduleName = (Get-Item $Path).BaseName
	Remove-Module $moduleName
	Import-Module $Path
}
