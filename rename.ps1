<#

PS function for renaming a file in a location

If you want to check if the file exists first, replace Remove-Item $old $new with the below

if (Test-Path $old)
{
    Rename-Item $old $new
}

If you want to archive the file, you can also add the below (you will need to update the function to include the archive location parameter)

Move-Item $new $archive

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
