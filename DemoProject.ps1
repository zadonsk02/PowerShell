#DemoProject.md

Get-ADUser -Filter * -Properties * | 
  where-object {$PSItem.City -eq 'London' -and $PSItem.Department -eq 'IT'} |
  Set-ADUser -Department 'LonIT'
