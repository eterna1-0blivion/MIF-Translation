# author: eterna1_0blivion
$version = 'v1.0.1'

# Set title and display a 'Loading...'
Clear-Host
$Host.UI.RawUI.WindowTitle = "Copy Files Script ($version)"
Write-Host "Loading..."

# Define initialPath and destinationPath
$initialPath = "$PSScriptRoot\.minecraft\resourcepacks"
$destinationPath = "$PSScriptRoot\..\MI-NH\.minecraft\resourcepacks"

# Copy files from initialPath to destinationPath
Copy-Item -Path "$initialPath\*" -Destination "$destinationPath" -Recurse -Force

# Notification of work successfully finished
    Write-Host "`nFiles copied successfully." -ForegroundColor Green
    Read-Host -Prompt "Press Enter to exit"
    Break
