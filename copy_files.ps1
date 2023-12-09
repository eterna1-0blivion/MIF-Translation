# author: eterna1_0blivion
$version = 'v1.0.2'

# Some variables for easy invocation
$theme = '$Host.UI.RawUI.BackgroundColor = "Black"; $Host.UI.RawUI.ForegroundColor = "Gray"; Clear-Host'
$exit = 'Read-Host -Prompt "Press Enter to exit"; Break'


# Set title, theme and display a 'Loading...'
$Host.UI.RawUI.WindowTitle = "Copy Files Script ($version)"
Invoke-Expression $theme
Write-Host "Loading..."

# Define initialPath and destinationPath
$initialPath = "$PSScriptRoot\.minecraft\resourcepacks\Translation Pack"
$destinationPath = "$PSScriptRoot\..\MI-NH\resourcepacks\Translation Pack"

# Copy files from initialPath to destinationPath
Copy-Item -Path "$initialPath\*" -Destination "$destinationPath" -Recurse -Force

# Notification of work successfully finished
Write-Host "`nFiles copied successfully." -ForegroundColor Green
Invoke-Expression $exit
