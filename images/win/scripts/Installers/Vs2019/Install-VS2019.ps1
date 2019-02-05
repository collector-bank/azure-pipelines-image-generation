################################################################################
##  File:  Install-VS2019.ps1
##  Team:  CI-Build
##  Desc:  Install Visual Studio 2019
################################################################################

Function InstallVS
{
  Param
  (
    [String]$WorkLoads,
    [String]$Sku,
    [String] $VSBootstrapperURL
  )

  $exitCode = -1

  try
  {
    Write-Host "Enable short name support on Windows needed for Xamarin Android AOT, defaults appear to have been changed in Azure VMs"
    $shortNameEnableProcess = Start-Process -FilePath fsutil.exe -ArgumentList ('8dot3name', 'set', '0') -Wait -PassThru
    $shortNameEnableExitCode = $shortNameEnableProcess.ExitCode

    if ($shortNameEnableExitCode -ne 0)
    {
      Write-Host -Object 'Enabling short name support on Windows failed. This needs to be enabled prior to VS 2017 install for Xamarin Andriod AOT to work.'
      exit $shortNameEnableExitCode
    }

    Write-Host "Downloading Bootstrapper ..."
    Invoke-WebRequest -Uri $VSBootstrapperURL -OutFile "${env:Temp}\vs_$Sku.exe"

    $FilePath = "${env:Temp}\vs_$Sku.exe"
    $Arguments = ('/c', $FilePath, $WorkLoads, '--quiet', '--norestart', '--wait', '--nocache' )

    Write-Host "Starting Install ..."
    $process = Start-Process -FilePath cmd.exe -ArgumentList $Arguments -Wait -PassThru
    $exitCode = $process.ExitCode

    if ($exitCode -eq 0 -or $exitCode -eq 3010)
    {
      Write-Host -Object 'Installation successful'
      return $exitCode
    }
    else
    {
      Write-Host -Object "Non zero exit code returned by the installation process : $exitCode."

      # this wont work because of log size limitation in extension manager
      # Get-Content $customLogFilePath | Write-Host

      exit $exitCode
    }
  }
  catch
  {
    Write-Host -Object "Failed to install Visual Studio. Check the logs for details in $customLogFilePath"
    Write-Host -Object $_.Exception.Message
    exit -1
  }
}

$WorkLoads = '--allWorkloads --includeRecommended ' + `
                '--add Microsoft.Net.Component.4.6.2.SDK ' + `
                '--add Microsoft.Net.Component.4.6.2.TargetingPack ' + `
                '--add Microsoft.Net.ComponentGroup.4.6.2.DeveloperTools ' + `
                '--add Microsoft.Net.Component.4.7.SDK ' + `
                '--add Microsoft.Net.Component.4.7.TargetingPack ' + `
                '--add Microsoft.Net.ComponentGroup.4.7.DeveloperTools ' + `
                '--add Microsoft.Net.Component.4.7.1.SDK ' + `
                '--add Microsoft.Net.Component.4.7.1.TargetingPack ' + `
                '--add Microsoft.Net.ComponentGroup.4.7.1.DeveloperTools ' + `
                '--add Microsoft.VisualStudio.Component.Windows10SDK.17134 ' + `
                '--add Microsoft.VisualStudio.Component.Windows10SDK.17763 '

$ReleaseInPath = 'Preview'
$Sku = 'Enterprise'
$VSBootstrapperURL = 'https://download.visualstudio.microsoft.com/download/pr/24b5224f-c1ec-400b-943a-3bbcdd6bd5d5/e53a2fe46e68bb91506658f39aeeb04e/vs_enterprise.exe'

$ErrorActionPreference = 'Stop'

# Install VS
$exitCode = InstallVS -WorkLoads $WorkLoads -Sku $Sku -VSBootstrapperURL $VSBootstrapperURL

# Find the version of VS installed for this instance
# Only supports a single instance
$vsProgramData = Get-Item -Path "C:\ProgramData\Microsoft\VisualStudio\Packages\_Instances"
$instanceFolders = Get-ChildItem -Path $vsProgramData.FullName

if($instanceFolders -is [array])
{
    Write-Host "More than one instance installed"
    exit 1
}

$catalogContent = Get-Content -Path ($instanceFolders.FullName + '\catalog.json')
$catalog = $catalogContent | ConvertFrom-Json
$version = $catalog.info.id
Write-Host "Visual Studio version" $version "installed"

# Updating content of MachineState.json file to disable autoupdate of VSIX extensions
$newContent = '{"Extensions":[{"Key":"1e906ff5-9da8-4091-a299-5c253c55fdc9","Value":{"ShouldAutoUpdate":false}},{"Key":"Microsoft.VisualStudio.Web.AzureFunctions","Value":{"ShouldAutoUpdate":false}}],"ShouldAutoUpdate":false,"ShouldCheckForUpdates":false}'
Set-Content -Path "C:\Program Files (x86)\Microsoft Visual Studio\2019\$ReleaseInPath\Common7\IDE\Extensions\MachineState.json" -Value $newContent


# Adding description of the software to Markdown

$SoftwareName = "Visual Studio 2019 Enterprise"

$Description = @"
_Version:_ $version<br/>
_Location:_ C:\Program Files (x86)\Microsoft Visual Studio\2019\$ReleaseInPath

All available workloads are installed with Visual Studio 2019.
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description

exit $exitCode