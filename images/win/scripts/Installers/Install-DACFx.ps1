####################################################################################
##  File:  Install-DACFx.ps1
##  Team:  CI-Platform
##  Desc:  Install SQL Server® Data-Tier Application Framework (DACFx) for Windows
####################################################################################

Import-Module -Name ImageHelpers -Force

$exitcode = Install-MSI -MsiUrl "https://download.microsoft.com/download/A/C/5/AC518FDC-E77F-49C8-A285-EB609C1354DF/EN/x64/DacFramework.msi" -MsiName "DacFramework.msi"

exit $exitcode
