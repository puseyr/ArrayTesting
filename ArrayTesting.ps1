$user1 = Import-Csv "\\usnycsrv2uwfp1\upf\rpusey-sa\WF\RF\Documents\PowerShell building\User Group Look up\puseyr.csv"
$user2 = Import-Csv "\\usnycsrv2uwfp1\upf\rpusey-sa\WF\RF\Documents\PowerShell building\User Group Look up\lydonc.csv"
 
#Compare both CSV files - column SamAccountName
$Results = Compare-Object  $user1 $user2 -Property Domain User -IncludeEqual
 
$Array = @()       
Foreach($R in $Results)
{
    If( $R.sideindicator -eq "==" )
    {
        $Object = [pscustomobject][ordered] @{
 
            Username = $R.SamAccountName
            "Compare indicator" = $R.sideindicator
 
        }
        $Array += $Object
    }
}
 
#Count users in both files
($Array | sort-object group | Select-Object * -Unique).count
 
#Display results in console
$Array