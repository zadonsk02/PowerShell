function Add-ADUser{

$UserList = Import-Csv -Path 'C:\Temp\NewHires.csv' 

foreach ($User in $UserList) {

     $Attributes = @{

        Enabled = $true
        ChangePasswordAtLogon = $true
        Path = "OU=Marketing,DC=adatum,DC=com"

        Name = "$($FirstName) $($LastName)"
        UserPrincipalName = "$($FirstName).$($LastName)@adatum.com"
        SamAccountName = "($FirstLetterLower[0]) -join $($LastNameLower)"

        GivenName = $User.First
        Surname = $User.Last

        Company = $User.Company
        Department = $User.Department
        Title = $User.Title
        AccountPassword = $User.password
        # AccountPassword = "TotallyFakePassword123" | ConvertTo-SecureString -AsPlainText -Force
     }
     
    # New-ADUser @Attributes
  }         
} # function Add-ADUser: https://www.pdq.com/blog/add-users-to-ad-with-powershell/