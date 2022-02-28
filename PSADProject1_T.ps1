function Test_Add-ADUser{

Param (
    [string]$FileName = 'E:\NewHires_short.csv'
  )
  $UserList = Import-Csv -Path $FileName

    foreach ($User in $UserList) {   
      $SamAccountName = ($User.firstname.SubString(0,1)+" "+$User.lastname)
      $Name = ($User.firstname+" "+$User.lastname)
      $AccountPassword = $User.password | ConvertTo-SecureString -AsPlainText -Force
   
      $Attributes = @{
        Enabled = $true
        ChangePasswordAtLogon = $false
        Path = "OU=Test,DC=adatum,DC=com"
        GivenName = $User.firstname
        Surname = $User.lastname
        Company = "A. Datum"
        #StreetAddress = $User.streetaddress
        StreetAddress = "Hillarys"
        Department = $User.department        
        Office = $User.officename
        AccountPassword = $AccountPassword
        Name = $Name
        UserPrincipalName = ($User.upn)
        SamAccountName = $SamAccountName
      }
    Test_Add-ADUser @Attributes #Create user account
    }
}