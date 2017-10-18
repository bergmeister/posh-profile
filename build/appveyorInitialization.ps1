if ($null -eq $PROFILE)
{
    $PROFILE = [System.IO.Path]::GetTempFileName() # to prevent AppVeyor from throwing an error when installing PoShFuck
}