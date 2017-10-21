# Global variable needed for mocking of some variables
[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidGlobalVars", "")]
param()

Describe 'posh-profile' {
    
    It "Can import module" {
        Import-Module (Join-Path (Split-Path $PSScriptRoot) 'posh-profile.psd1') -DisableNameChecking
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

    It "reimports module does not throw" {
        $gitUtilsModule = [System.IO.Path]::Combine((Split-Path $PSScriptRoot), 'source\gitUtils\gitUtils.psd1') 
        $gitUtilsModule | Should Exist
        Remove-Module gitUtils -Force
        Import-Module $gitUtilsModule
        ReImport-Module $gitUtilsModule
        # Get-Module gitUtils | Should Not Be $null # TODO: find out why this fails in CI
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

}

