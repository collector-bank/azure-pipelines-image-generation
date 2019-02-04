# Azure Pipelines Hosted Windows 2019 with VS2019 image

The following software is installed on machines in the Azure Pipelines **Hosted Windows 2019 with VS2019** pool.

Components marked with **\*** have been upgraded since the previous version of the image.


## Chocolatey

_Version:_ 0.10.11<br/>
_Environment:_
* PATH: contains location for choco.exe

## Powershell Core

_Version:_ 6.1.1<br/>

## Visual Studio 2019 Enterprise

_Version:_ VisualStudioPreview/16.0.0-pre.2.0+28522.59<br/>
_Location:_ C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview

All available workloads are installed with Visual Studio 2019.

## Node.js

_Version:_ 10.15.0<br/>
_Environment:_
* PATH: contains location of node.exe<br/>
* Gulp [[90m16:33:49[39m] CLI version 2.0.1<br/>
* Grunt grunt-cli v1.3.2<br/>
* Bower 1.8.8<br/>
* Yarn 1.13.0<br/>

> Note: You can install and use another version of Node.js on Microsoft-hosted agent pools using the [Node tool installer](https://docs.microsoft.com/vsts/pipelines/tasks/tool/node-js) task.

## npm

_Version:_ 6.7.0<br/>
_Environment:_
* PATH: contains location of npm.cmd

## WIX Tools

_Toolset Version:_ 3.11.2318<br/>
_Environment:_
* WIX: Installation root of WIX

## Azure/AzureRM Powershell modules

#### 2.1.0

This version is installed and is available via Get-Module -ListAvailable
#### 3.8.0

This version is saved but not installed
_Location:_ C:\Modules\azurerm_3.8.0\AzureRM\3.8.0\AzureRM.psd1

#### 4.2.1

This version is saved but not installed
_Location:_ C:\Modules\azurerm_4.2.1\AzureRM\4.2.1\AzureRM.psd1

#### 5.1.1

This version is saved but not installed
_Location:_ C:\Modules\azurerm_5.1.1\AzureRM\5.1.1\AzureRM.psd1

#### 6.7.0

This version is saved but not installed
_Location:_ C:\Modules\azurerm_6.7.0\AzureRM\6.7.0\AzureRM.psd1


## Azure CLI

_Version:_ 2.0.54<br/>
_Environment:_
* PATH: contains location of az.cmd

## TypeScript

_Version:_ Version 3.2.4<br/>
