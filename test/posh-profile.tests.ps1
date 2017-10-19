Describe 'posh-profile.psm1' {
    
    Import-Module (Join-Path (Split-Path $PSScriptRoot) 'posh-profile.psm1') -DisableNameChecking

    It "Set-MsBuildExeVariablesForEnterpriseEdition has set variables" {
        $msBuildVS2015 | Should Not BeNullOrEmpty
        $msBuildVS2017 | Should Not BeNullOrEmpty
        $msBuildVS2017Preview | Should Not BeNullOrEmpty
    }

    It "'which' works with cmd" {
        which 'cmd' | Should Contain 'cmd.exe'
    }

    It "Save-History produces file with history" {
        $childItem = Get-ChildItem # invoke some command
        try
        {
            $tempFile = [System.IO.Path]::GetTempFileName()
            Save-History $tempFile
            Get-Content $tempFile -Raw | Should BeLike '*Get-ChildItem*'
        }
        finally
        {
            Remove-Item $tempFile
        }
    }
}
