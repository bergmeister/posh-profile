Describe 'macAddressUtils.psm1' {

    It "imports OK" {
        Import-Module (Join-Path (Split-Path $PSScriptRoot) 'source\macAddressUtils\macAddressUtils.psd1')
    }
    
    It "Update-MacAddressVendor does not throw" {
        Update-MacAddressVendor
    }

    It "Get-MacAddressVendor" {
        $macAddress = Get-CimInstance win32_networkadapterconfiguration | Select-Object macaddress | Where-Object {
                        ! [string]::IsNullOrEmpty($_.macaddress) }  | Select-Object -First 1
        Get-MacAddressVendor $macAddress.macAddress | Should Not BeNullOrEmpty
    }
}