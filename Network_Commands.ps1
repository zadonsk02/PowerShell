#Show any DNS problems
Get-DnsClientCache
#If bad entires, eg NOT EXIST when the entry should:
Clear-DnsClientCache