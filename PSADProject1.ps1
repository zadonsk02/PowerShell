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
    [string]$FileName = 'E:\NewHires.csv'
  )
  $UserList = Import-Csv -Path $FileName

  $DepartmentNames = $UserList.Department | Select-Object -Unique # Get an array of all of the Departments that are needed
  $CurrentOUNames = (Get-ADOrganizationalUnit -Filter *).Name # Get an array of OU names
  $CurrentGroupNames = (Get-ADGroup -Filter *).Name # Get an array of Group names
  foreach ($DepartmentName in $DepartmentNames) { # Checking to see if the OUs and Groups are already created
    if ($DepartmentName -notin $CurrentOUNames) {
      New-ADOrganizationalUnit -Name $DepartmentName -Path 'dc=adatum,dc=com'
    }
    if ($DepartmentName -notin $CurrentGroupNames) {
      New-ADGroup -GroupScope Global -Name $DepartmentName -Path "ou=$DepartmentName,dc=adatum,dc=com"
    }
  }
    
  $UserTotalCount = $UserList.Count
  $CurrentUserCount = 0  

  foreach ($User in $UserList) {   
    #Print to screen user creation progress.
    $CurrentUserCount++
    Write-Progress -Activity "Creating Users" -PercentComplete ($CurrentUserCount/$UserTotalCount*100) -CurrentOperation  "Creating User: $($User.FirstName + ' ' + $User.LastName)"
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
       StreetAddress = $User.streetaddress
       Department = $User.department        
       Office = $User.officename
       AccountPassword = $AccountPassword
       Name = $Name
       UserPrincipalName = ($User.upn)
       SamAccountName = $SamAccountName
       }
    New-ADUser @Attributes #Create user account
    $NewUser = Get-ADUser -Identity $SamAccountName
    Add-ADGroupMember -Identity $User.department -Members $NewUser  # Adding the new user to the relevant group
  }
}#function Add-ADUser
