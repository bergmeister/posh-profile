# Global variable needed for mocking of $psISE variable for tests of Set-LocationToCurrentIseItem
[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidGlobalVars", "")]
param()

Describe 'posh-profile.psm1' {
    
    It "Can import module" {
        Import-Module (Join-Path (Split-Path $PSScriptRoot) 'posh-profile.psm1') -DisableNameChecking
    }

    It "Set-MsBuildExeVariablesForEnterpriseEdition has set variables" {
        $msBuildVS2015 | Should Not BeNullOrEmpty
        $msBuildVS2017 | Should Not BeNullOrEmpty
        $msBuildVS2017Preview | Should Not BeNullOrEmpty
    }

    It "'which' works with cmd" {
        which 'cmd' | Should Contain 'cmd.exe'
    }

    It "Set-LocationToCurrentIseItem works if ISE environment variable is set" {
        
        $initialLocation = Get-Location
        try {
            $tempFolder = [System.IO.Path]::GetTempPath()
            $currentLocation = (Get-Location).Path
            $global:psISE = @{CurrentFile=@{}}
            $global:psISE.CurrentFile.Add('FullPath',$tempFolder)
            Set-LocationToCurrentIseItem
            (Get-Location).Path | Should Be (Split-Path $tempFolder)
        }
        finally {
            Set-Location $initialLocation
        }
    }
}

