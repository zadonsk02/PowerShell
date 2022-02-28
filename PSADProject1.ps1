function Add-ADUser{
  <#
  .SYNOPSIS
  .DESCRIPTION
  Each New User is described in a structure known as a splatted variable. 
  Splatting is a method of passing a collection of parameter values to a command as a unit. 
  PowerShell associates each value in the collection with a command parameter. 
  Splatted parameter values are stored in named splatting variables, which look like standard variables, 
  but begin with an At symbol (@) instead of a dollar sign ($). 
  The At symbol tells PowerShell that you are passing a collection of values, instead of a single value.

  .EXAMPLE

  .PARAMETER 

  .NOTES
  General Notes
    Created by:    Andrew Konigsberg
    Created on:    28 Feb 2022
    Last Modified: 28 Feb 2022

  #>
  [cmdletbinding()]
  Param (
    [string]$FileName = "E:\NewHires.csv"
  )
  $UserList = Import-Csv -Path $FileName
  
  $UserTotalCount = $Users.Count
    $CurrentUserCount = 0  

  foreach ($User in $UserList) {   
    #Print to screen user creation progress.
    $CurrentUserCount++
    Write-Progress -Activity "Creating Users" -PercentComplete ($CurrentUserCount/$UserTotalCount*100) -CurrentOperation  "Creating User: $($User.FirstName + ' ' + $User.LastName)"

    $Attributes = @{
       #Enabled = $true
       #ChangePasswordAtLogon = $false
       Path = "OU=Test,DC=adatum,DC=com"
       GivenName = $User.firstname
       Surname = $User.lastname
       Company = "A. Datum"
       StreetAddress = $User.streetaddress
       Department = $User.department        
       Office = $User.officename
       AccountPassword = $User.password | ConvertTo-SecureString -AsPlainText -Force
       Name = ($User.firstname+" "+$User.lastname)
       UserPrincipalName = ($User.upn)
       SamAccountName = ($User.firstname+" "+$User.lastname)
       }
     Add-ADUser @Attributes #Call function Add-ADUser to create user account
  }
}#function Add-ADUser
