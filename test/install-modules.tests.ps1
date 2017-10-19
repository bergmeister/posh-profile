Describe 'Modules are installed' {

    It "Module '<moduleName>' is installed" -TestCase @(
        @{ moduleName = "Pester";  }
        @{ moduleName = "posh-docker";  }
        @{ moduleName = "posh-git"; }
        @{ moduleName = "posh-with"; }
        @{ moduleName = "PoShFuck"; }
        @{ moduleName = "Jump.Location"; }
        @{ moduleName = "PSScriptAnalyzer"; } ){
        Param ($moduleName)
          Get-Module -ListAvailable $moduleName | Should Not Be $null
    }
}