# The following commands find all locked-out accounts and inactive accounts belonging to both users and computers.
#Ref: Frommherz, Florian. Manage Windows AD with PowerShell, Admin: Network & Security, Issue 64.
Search-ADAccount -LockedOut
Search-ADAccount -AccountInactive
  -TimeSpan 120.00:00:00 |
  Format-Table Name,LastLogonDate,Enabled

#Overview of a Group's properties
Get-ADGroup
-Filter "GroupCategory" -eq "Security"
-SearchBase "OU=Groups,DC=adatum,DC=com"
 
#Find Group Members, with the Recursive option resolving nested group memberships.
Get-ADGroupMember
  -Identity 'Domain Admins' -Recursive |
  Get-ADUser 
    -Properties EmailAddress,lastLogonDate |
    Export-Csv -Path "C:\Temp\DomainAdmins.csv"

#Find FSMO Role Holders.
Get-ADForest |
  Select-Object DomainNamingMaster,SchemaMaster

Get-ADDomain |
  -Name adatum.com |
  Select-Object InfrastructureMaster,PDCEmulator,RIDMaster

#Making Changes:
# Modify Users of a certain OU so that they all have a certain attribute value, 
# other programs (eg AADConnect for sync to the cloud) to find and process them.
Get-ADUSer -Filter *
  -SearchBase "OU=Marketing,DC=adatum,DC=com" |
  Set-ADUser
    -Add @{extensionAttribute4 = "M365"}

#Edit multiple users with an imported CSV:
Import-Csv "C:\Temp\Users.csv" |
  % {If($_.mail -like '*@adatum.com')
  { Set-ADUser $_.SamAccountName
    -Add @{extensionAttribute4 = "M365"}}}
    
#Move Lara from IT to Sale, using Move-ADObject:
Get-ADUSer -Identity Lara | Move-ADObject -TargetPath 'OU=Sales,DC=adatum,DC=com'