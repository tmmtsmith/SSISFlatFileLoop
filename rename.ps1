<#

PS function for renaming a file in a location

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
