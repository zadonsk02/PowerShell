function Add-ADUser{
  [cmdletbinding()]
  Param (
    [string]$UserList = Import-Csv -Path 'C:\Temp\NewHires.csv'
  )
  foreach ($User in $UserList) {   
    $Attributes = @{

        Enabled = $true
        ChangePasswordAtLogon = $true
        Path = "OU=Marketing,DC=adatum,DC=com"

        $FirstName = $User.First
        $LastName = $User.Last
        Name = "$($FirstName) $($LastName)"

        UserPrincipalName = "$($FirstName).$($LastName)@adatum.com"
        $FirstLetter = $FirstName.StartsWith()
        $LastNameLower = $LastName.ToLower()
        SamAccountName = "($FirstLetterLower[0]) -join $($LastNameLower)"

        GivenName = $User.First
        Surname = $User.Last

        Company = $User.Company
        Department = $User.Department
        Title = $User.Title
        AccountPassword = $User.password
        
     }

    New-ADUser @Attributes
  }         
} # function Add-ADUser