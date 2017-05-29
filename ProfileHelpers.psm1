Function Set-LocationToCurrentIseItem
{
	if($null -eq $psISE)
	{
		Write-Error "Function only supported in PowerShell ISE"
	}
	else
	{
		Set-Location (Split-Path $psISE.CurrentFile.FullPath -Parent)
	}
}

Function gh
{
	(Get-History).CommandLine
}