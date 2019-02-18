################################################################################
##  File:  Install-Python.ps1
##  Team:  CI-X
##  Desc:  Configure python on path based on what VS installs
##         Must run after VS is installed
################################################################################

Import-Module -Name ImageHelpers -Force

$pythonDir = Get-Item -Path 'C:\Program Files (x86)\Microsoft Visual Studio\Shared\Python3*'

if($pythonDir -is [array])
{
    Write-Host "More than one python 3 install found"
    Write-Host $pythonDir
    exit 1
}

$currentPath = Get-MachinePath

if ($currentPath | Select-String -SimpleMatch $pythonDir.FullName)
{
    Write-Host $pythonDir.FullName ' is already in path'
    exit 0
}

Add-MachinePathItem -PathItem $pythonDir.FullName
Add-MachinePathItem -PathItem "$($pythonDir.FullName)\Scripts"
setx PYTHON_HOME $pythonDir.FullName /M
