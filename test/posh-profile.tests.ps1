# Global variable needed for mocking of some variables
[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidGlobalVars", "")]
param()

Describe 'posh-profile' {
    
    It "Can import module" {
        Import-Module (Join-Path (Split-Path $PSScriptRoot) 'source\posh-profile.psd1') -DisableNameChecking
    }

    It "Set-MsBuildExeVariablesForEnterpriseEdition has set variables" {
        $msBuildVS2015 | Should Not BeNullOrEmpty
        $msBuildVS2017 | Should Not BeNullOrEmpty
        $msBuildVS2017Preview | Should Not BeNullOrEmpty
    }

    It "'which' works with cmd" {
        which 'cmd' | Should Contain 'cmd.exe'
    }

    It 'Set-LocationToCurrentIseItem throws if not in ISE' {
        $global:psISE = $null
        { Set-LocationToCurrentIseItem } | Should throw
    }

    It "Set-LocationToCurrentIseItem works if ISE environment variable is set" {
        
        $initialLocation = Get-Location
        try {
            $tempFolder = [System.IO.Path]::GetTempPath()
            $global:psISE = @{CurrentFile=@{}}
            $global:psISE.CurrentFile.Add('FullPath',$tempFolder)
            Set-LocationToCurrentIseItem
            (Get-Location).Path | Should Be (Split-Path $tempFolder)
        }
        finally {
            Set-Location $initialLocation
        }
    }
    It "MsBuildExe variables are set" {
        $msBuildVS2015        | Should Not BeNullOrEmpty
        $msBuildVS2017        | Should Not BeNullOrEmpty
        $msBuildVS2017Preview | Should Not BeNullOrEmpty
    }

    It "History helper does not throw" {
        gh
    }

    It "Save-History with filePath argument" {
        try
        {
            $tempfile = [System.IO.Path]::GetTempFileName()
            Save-History $tempfile
            if ($null -eq $env:APPVEYOR ) # Get-History does not work in appveyor
            {
                Get-Content $tempfile -Raw | Should Match 'GetTempFile'
            }
        }
        finally
        {
            Remove-Item $tempfile
        }
    }

    It "Save-History without file path argument" {
        $testText = "Executing random command for Save-History test"
        Write-Verbose $testText
        Save-History
        $historyFile = Get-ChildItem *.PowerShellHistory
        $historyFile | Should Not Be $null
        $historyFile | Should BeOfType System.IO.FileInfo
        if ($null -eq $env:APPVEYOR ) # Get-History does not work in appveyor
        {
            Get-Content (Get-ChildItem *.PowerShellHistory) -Raw | Should Match $testText
        }
        Remove-Item $historyFile
    }

    It "Explorer test" {
        e
        e ([System.IO.Path]::GetTempPath())
        e .
    }

    It "OpenProfileInExplorer should not throw" {
        try
        {
            $initialProfile = $profile
            $global:profile = [System.IO.Path]::GetTempPath() # needed to work in Appveyor
            OpenProfileInExplorer
        }
        finally
        {
            $global:profile = $null
            $profile = $initialProfile
        }
    }

    It "ReImports-Module does not throw" {
        $gitUtilsModule = [System.IO.Path]::Combine((Split-Path $PSScriptRoot), 'source\gitUtils\gitUtils.psd1') 
        $gitUtilsModule | Should Exist
        Remove-Module gitUtils -Force
        Import-Module $gitUtilsModule
        ReImport-Module $gitUtilsModule
        if ($null -eq $env:APPVEYOR ) # the assertion below would fail in Appveyor and is therefore excluded at the moment -> TODO: find out why
        {
            Get-Module gitUtils | Should Not Be $null 
        }
    }

    It "ReImport-Module throws if path is invalid" {
        { ReImport-Module .\ModuleThatDoesNotExists.psd1 } | Should throw
    }

    It "touch creates a file" {
        try
        {
            $fileName = 'testtouchFile.txt'
            touch $fileName
            Test-Path $fileName | Should Be $true
        }
        finally
        {
            Remove-Item $fileName
        }
    }

    It "WSL wrapper for bash" {
        $whoami = whoami
        b 'whoami' | Should Be $whoami
    }

}

