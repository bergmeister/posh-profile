Describe 'dotnetCli' {
    
    It "Imports OK" {
        Import-Module (Join-Path (Split-Path $PSScriptRoot) 'source\dotnetCli\dotnetCli.psd1')
    }
    
    It "Dotnet Command wrappers" {
        try {
            $tempFolder = New-Item -ItemType Directory -Name tempdotnetCliTestFolder
            Set-Location $tempFolder
            Get-Command dotnet | Should Not Be Null
            dotnet new xunit # this does not work in CI unfortunately
            dotnetclean
            dotnetrestore
            dotnetbuild
            dotnettest
            dotnetpublish
            Get-ChildItem 'publish' -recurse | Should Exist
            Write-Host "-----------DOTNET TEST PASSED---------"
        }
        finally {
            Set-Location ..
            Remove-Item $tempFolder -Recurse -Force
        }
    }
}
