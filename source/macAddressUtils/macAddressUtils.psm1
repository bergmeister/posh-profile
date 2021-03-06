<#
.SYNOPSIS
    A simple script to retrieve MAC Address vendor by supplying MAC address
.DESCRIPTION
    This script downloads wireshark's Vendors Mac Address List from their gitweb.
    This script has two functions in it:
        * Update-MacAddressVendor
        * Get-MacAddressVendor
    Update-MacAddressVendor downloads the current vendor file and places it in a given directory, 
    determined by the $DocumentPath variable.
    Get-MacAddressVendor searches through the downloaded file for the three first octets of the MAC Address, 
    and hopefully retrieves the correct vendor of it. 
.EXAMPLE
    # Update Vendor List
    Update-MacAddressVendor
    # Search through vendor list
    Get-MacAddressVendor -MacAddress '00-50-56-C0-00-00'
    ===================RESULT===================
    00:50:56	Vmware	VMware, Inc.
    ============================================
    
.NOTES
    Script written by CodeBarbarian @ https://github.com/CodeBarbarian
#>

<#
.Synopsis
   Where the vendor mac addresses textfile will be located
#>
function Get-DefaultDocumentPath
{
    return (Join-Path $ENV:HOMEPATH Desktop)
}

function Update-MacAddressVendor
{
    [CmdletBinding(SupportsShouldProcess=$true)] 
    param
    (
        $DocumentPath
    )

    if ([string]::IsNullOrEmpty)
    {
        $DocumentPath = Get-DefaultDocumentPath
    }

    # Path to the wireshark repository
    $APIUrl = 'https://code.wireshark.org/review/gitweb?p=wireshark.git;a=blob_plain;f=manuf;hb=HEAD'
    $downloadPath = "$($DocumentPath)\vendor_macaddresses.txt"
    
    if ($PSCmdlet.ShouldProcess("Updating Mac address vendor from url $($APIUrl) in $($downloadPath)"))
    {
        Write-Verbose "Updating MAC vendor list"
        $WebClient = New-Object System.Net.WebClient
        $WebClient.DownloadFile($APIUrl, $downloadPath)
        Write-Verbose "Update of MAC vendor list complete"
    }
}

function Get-MacAddressVendor
{
    [cmdletbinding()]
    param (
        [parameter(mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]$MacAddress,

        $DocumentPath
    )

    if ([string]::IsNullOrEmpty)
    {
        $DocumentPath = Get-DefaultDocumentPath
    }

    # Remove everything we really do not need from the mac address
    $MacAddress = $MacAddress -replace "[-,.:]", ""
    
    # Prepare the placeholder for the search query
    $Placeholder = "HOLD1:HOLD2:HOLD3"
    $Placeholder = $Placeholder.Replace("HOLD1", $MacAddress.Substring(0,2))
    $Placeholder = $Placeholder.Replace("HOLD2", $MacAddress.Substring(2,2))
    $Placeholder = $Placeholder.Replace("HOLD3", $MacAddress.Substring(4,2))

    # Set the mac address to become the mac address in same format as wireshark uses
    $MacAddress = $Placeholder
    
    # Let us just make sure we did not mess up somewhere
    $RegEx = '(?<macaddr>[0-9A-Fa-f][0-9A-Fa-f]:[0-9A-Fa-f][0-9A-Fa-f]:[0-9A-Fa-f][0-9A-Fa-f])'

    # Get contents from file
    $File = Get-Content ("$($DocumentPath)\vendor_macaddresses.txt")

    # Iterate through the file
    foreach ($Line in $File) {
        # Only check on Mac Address first
        if ($Line -match $RegEx) {
            # Check if the mac address is in the list
            if ($Matches.values -Match $MacAddress) {
                # Give response viewing the entire line
                return $Line
            }
        }
    }
}
