Function New-Branch
{
	[CmdletBinding(SupportsShouldProcess=$true)]
	Param
	(
		$BranchName
	)

	if ($PSCmdlet.ShouldProcess("Creating new branch  $($BranchName) and updating submodule"))
	{
		git checkout -b $BranchName
		git submodule update
	}
}

Function Update-GitRepo
{
	[CmdletBinding(SupportsShouldProcess=$true)] Param()
	
	if ($PSCmdlet.ShouldProcess("Executing 'git pull' and 'git submodule update'"))
	{
		git pull
		git submodule update
	}
}

Function Update-GitSubmoduleRemote
{
	[CmdletBinding(SupportsShouldProcess=$true)] Param()
	
	if ($PSCmdlet.ShouldProcess("Executing 'git submodule update --remote'"))
	{
		git submodule update --remote
	}
}

Function Update-GitSubmodule
{
	[CmdletBinding(SupportsShouldProcess=$true)] Param()
	
	if ($PSCmdlet.ShouldProcess("Executing 'git submodule update'"))
	{
		git submodule update
	}
}


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
Function New-RemoteBranch
{
    [CmdletBinding(SupportsShouldProcess=$true)]
    Param
    (
        [Parameter(Mandatory=$true)]
        $BranchName
    )
	
	if ($PSCmdlet.ShouldProcess("Executing 'git pull; git checkout -b $BranchName; git push -u origin $BranchName'"))
	{
		git checkout develop; git pull; git checkout -; git merge develop
	}
}
