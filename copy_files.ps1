# author: eterna1_0blivion
$version = 'v1.0.2'

# Some variables for easy invocation
$theme = '$Host.UI.RawUI.BackgroundColor = "Black"; $Host.UI.RawUI.ForegroundColor = "Gray"; Clear-Host'
$exit = 'Read-Host -Prompt "Press Enter to exit"; Break'


# Set title, theme and display a 'Loading...'
$Host.UI.RawUI.WindowTitle = "Copy Files Script ($version)"
Invoke-Expression $theme
Write-Host "Loading..."

$resolve = Read-Host -Prompt "`nCopy one pack or all packs? [O]ne | [A]ll"
if ($resolve -eq 'O') {
    # Define initialPath and destinationPath for one
    $initialPath = "$PSScriptRoot\.minecraft\resourcepacks\Translation Pack"
    $destinationPath = "$PSScriptRoot\..\MIF-Restitched\resourcepacks\Translation Pack"
} elseif ($resolve -eq 'A') {
    # Define initialPath and destinationPath for all
    $initialPath = "$PSScriptRoot\.minecraft\resourcepacks"
    $destinationPath = "$PSScriptRoot\..\MIF-Restitched\resourcepacks"
} else {
    # Script stopped
    Write-Host "`nYou've stopped the script from running." -ForegroundColor Yellow
    Invoke-Expression $exit
}

# Copy files from initialPath to destinationPath
Copy-Item -Path "$initialPath\*" -Destination "$destinationPath" -Recurse -Force

# Notification of work successfully finished
Write-Host "`nFiles copied successfully." -ForegroundColor Green
Invoke-Expression $exit
