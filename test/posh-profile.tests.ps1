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
}

Describe 'posh-profile.psm1 tests that do not work in AppVeyor' -Tag 'NotAppVeyor' {
    
    It "Save-History produces file with history"  {
        Get-ChildItem | Out-Null # invoke some command
        try
        {
            $historyFile = 'myhistory.txt'
            Save-History $historyFile
            Get-Content $historyFile -Raw | Should BeLike '*Get-ChildItem*'
        }
        finally
        {
            Remove-Item $historyFile
        }
    }
}
