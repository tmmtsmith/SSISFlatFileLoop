<#

PS function for renaming a file in a location

If you want to check if the file exists first, replace Remove-Item $old $new with the below

if (Test-Path $old)
{
    Rename-Item $old $new
}

#>

Function RenameFile ($location, $filename, $extension)
{

    $d = Get-Date -uFormat "%Y%m%d"

    $old = $location + $filename + $extension
    $new = $filename + "_" + $d + $extension
    

    Rename-Item $old $new

}

## Input values below:
RenameFile -location "" -file "" -extension ""
