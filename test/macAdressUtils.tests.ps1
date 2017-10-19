Describe 'macAddressUtils.psm1' {

    Import-Module (Join-Path (Split-Path $PSScriptRoot) 'macAddressUtils.psm1')
    
        It "Update-MacAddressVendor does not throw" {
            Update-MacAddressVendor
        }

        It "Get-MacAddressVendor" {
            $macAddress = Get-NetAdapter | Where Name -eq WiFi | Select -Expand MacAddress
            Get-MacAddressVendor $macAddress | Should Not BeNullOrEmpty
        }
    }