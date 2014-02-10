<#

  Powershell rename flat files in a folder, loop and import them into SQL Server, archive them.

  This script will require editing.
  
#>


##  Job Step 1

$d = Get-Date -uFormat "%Y%m%d"
$x = "_" + $d + ".txt"
Get-ChildItem "C:\files\*.txt" | Rename-Item -NewName {$_.Name -replace ".txt",$x}


##  Job Step 2
Function Loop_InsertData ($server, $database, $location)
{
    $dest = New-Object System.Data.SqlClient.SQLConnection
    $dest.ConnectionString = "SERVER=" + $server + ";DATABASE=" + $database + ";Integrated Security=True"
    $insert = New-Object Data.SqlClient.SqlCommand
    $fs = Get-ChildItem $location -Filter *.txt

    foreach ($f in $fs)
    {
        $dest.Open()
        $fn = $f.Name
        $all = $location + $fn
        $insert.CommandText = "EXECUTE stp_Loop_InsertData @fn"
        $insert.Parameters.Add("@fn", $all)
        $insert.Connection = $dest
        $insert.ExecuteNonQuery()
        $insert.Parameters.Clear()
        $dest.Close()
        
    }
    
}

Loop_InsertData -server "" -database "" -location ""

<# 

-- TSQL Procedure

CREATE PROCEDURE stp_Loop_InsertData
@file NVARCHAR(250)
AS
BEGIN

	DECLARE @f NVARCHAR(250), @s NVARCHAR(MAX)
	SET @f = @file
	
	SET @s = N'BULK INSERT SavingsTable
		FROM ''' + @f + '''
		WITH (
			FIELDTERMINATOR = '',''
			,ROWTERMINATOR = ''0x0a''
		)'
	
	EXEC sp_executesql @s

END

#>


## Job Step 3
Move-Item "C:\files\*.txt" "C:\files\Archive\"


