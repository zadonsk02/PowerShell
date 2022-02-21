# The following commands find all locked-out accounts and inactive accounts belonging to both users and computers.
#Ref: Frommherz, Florian. Manage Windows AD with PowerShell, Admin: Network & Security, Issue 64.
Search-ADAccount -LockedOut
Search-ADAccount -AccountInactive
  -TimeSpan 120.00:00:00 |
  Format-Table Name,LastLogonDate,Enabled
 
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

