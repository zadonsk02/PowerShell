#Show any DNS problems
Get-DnsClientCache
#If bad entires, eg NOT EXIST when the entry should:
Clear-DnsClientCache
#View Access Control List
Get-Acl -Path C:\Temp | Format-Table
(Get-Acl -Path C:\Temp).access | Format-Table