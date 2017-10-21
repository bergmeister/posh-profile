Describe 'gitUtils' {
    
    It "Imports OK" {
        Import-Module (Join-Path (Split-Path $PSScriptRoot) 'source\gitUtils\gitUtils.psd1')
    }

    It "g aliases git" {
        Get-Command g | Should Not Be $null
    }

    It "Supports ShouldProcess" {
        Update-GitRepo -WhatIf
        Update-GitSubmodule -WhatIf
        Update-GitSubmoduleRemote -WhatIf
        New-Feature myfeatureName -WhatIf
        Update-BranchFromDevelop -WhatIf
        New-RemoteBranch newBranchName -WhatIf
    }
    
    It "git Command wrappers" {
        try {
            $initialLocation = (Get-Location).Path
            $tempFolder = New-Item -ItemType Directory -Name tempgitUtilsTestFolder
            Set-Location $tempFolder
            Get-Command git | Should Not Be Null

            git clone https://github.com/bergmeister/posh-profile.git
            Set-Location posh-profile
            Update-GitRepo
            Update-GitSubmoduleRemote
            Update-GitSubmodule
            Checkout-GitRepo 'develop'
            Checkout-GitRepo 'feature'            
        }
        finally {
            Set-Location $initialLocation
            Remove-Item $tempFolder -Recurse -Force
        }
    }
}