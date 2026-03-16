Import-Module ActiveDirectory

#$Groups = "GroupNAMECHANGEME"
$Groups = "GroupNAMECHANGEME"
$OutFile = "C:\TEMP\UsersGroupExport.csv"
$Export = @()


function GetUsersInGroup($GroupToCheck){
    $StuffToExport = @()

    $Users = Get-ADGroupMember -Identity $GroupToCheck -ErrorAction SilentlyContinue

    foreach ($User in $Users){
        if ($User.ObjectClass -eq "user"){

            $USERER = Get-ADUser -Identity $User -Properties DistinguishedName, Company, DisplayName, SamAccountName, EmailAddress, Enabled, LastLogonDate
            
            $UserInfo = New-Object PSObject -Property @{
                DisplayName = $USERER.DisplayName
                SamAccountName = $USERER.SamAccountName
                Email = $USERER.EmailAddress
                Group = $Group
                NestedGroup = $GroupToCheck.Name
                DistinguishedName = $USERER.DistinguishedName
                Enabled = $USERER.Enabled
                LastLogOnDate = $USERER.LastLogonDate
                Company = $USERER.company
            }
            $ToExport = $UserInfo | Select-Object Group, NestedGroup, DistinguishedName, Company, DisplayName, SamAccountName, Email, Enabled, LastLogonDate
            $StuffToExport += $ToExport

            Write-Host -ForegroundColor Green $UserInfo

        }
        else {

            Write-Host -ForegroundColor Yellow "Calling the function again now" $User
            GetUsersInGroup $User
            
        }

        

    }
    return $StuffToExport
}


foreach ($Group in $Groups){
    
    $Export += GetUsersInGroup $Group
       

}

$Export | Export-Csv -Path $OutFile -NoTypeInformation 