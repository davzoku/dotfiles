# Powershell Profile forked from Adriano Cahete [ https://github.com/AdrianoCahete/Windows.Workspace ]

#Load PS scripts
$DocumentsFolder = [Environment]::GetFolderPath("MyDocuments")
$PSdir = Join-Path $DocumentsFolder "\WindowsPowerShell\scripts\autoload"
#Get-ChildItem "${PSdir}\*.ps1" | %{.$_}

# Data Vars
$Date = Get-Date -Format dd-MM-yyyy
$Time = Get-Date -Format HH:mm

# Shell Modifications
$Shell = $Host.UI.RawUI

# Colors
$host.PrivateData.ErrorBackgroundColor = "Black"
$host.PrivateData.DebugBackgroundColor = "Black"
$Host.UI.RawUI.ForegroundColor = "White"
$Host.PrivateData.ProgressForegroundColor = "Cyan"
$Host.PrivateData.ProgressBackgroundColor = "Black"
set-psreadlineoption -t parameter darkgreen
set-psreadlineoption -t operator darkgreen
set-psreadlineoption -t string darkgreen

# Window Size
$Shell.WindowSize.width=175
$Shell.WindowSize.height=52

# Set BufferSize
$Shell.BufferSize.width=150
$Shell.BufferSize.height=5000

# Set Default Location
Set-Location C:\

# Aliases
# Create your aliases here
Set-Alias e exercism
Set-Alias g git

function cdls
{
    param($path)
    cd $path 
    ls
}
${function:gh} = 
{ 
    cd C:\code\github
}

${function:svn} = { 
    cd C:\code\svn
}

${function:gs} = { 
    git status
}

${function:ga} = { 
    git add .
}

# Clear Window
Clear-Host

# ISE
if ($psISE) {
	#Start-Steroids
}

# Data
Write-Output "`n[ $Date @ $Time ]"
$datetime = echo "$Date @ $Time"

# Admin
if ($host.UI.RawUI.WindowTitle -match "Administrador" -Or $host.UI.RawUI.WindowTitle -match "Administrator") {
	Write-Output "`n[ Running as Administrator ]`n"
}

# Infos
Write-Host "[ Welcome, $env:USERNAME! ]`n" 
try { $null = gcm pshazz -ea stop; pshazz init 'monokaivs' } catch { }

#Loads git/npm
#. '$PSdir\profile_posh-git.ps1'


# Chocolatey profile
#$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
#if (Test-Path($ChocolateyProfile)) {
#  Import-Module "$ChocolateyProfile"
#}
