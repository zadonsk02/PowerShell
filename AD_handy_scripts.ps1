# The following commands find all locked-out accounts and inactive accounts belonging to both users and computers.
#Ref: Frommherz, Florian. Manage Windows AD with PowerShell, Admin: Network & Security, Issue 64.
Search-ADAccount -LockedOut
Search-ADAccount -AccountInactive
  -TimeSpan 120.00:00:00 |
  Format-Table Name,LastLogonDate,Enabled
  
