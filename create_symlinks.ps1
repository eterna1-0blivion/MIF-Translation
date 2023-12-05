# author: eterna1_0blivion
$version = 'v1.1.15'

# Some variables for easy invocation
$theme = '$Host.UI.RawUI.BackgroundColor = "Black"; $Host.UI.RawUI.ForegroundColor = "Gray"; Clear-Host'
$exit = 'Read-Host -Prompt "Press Enter to exit"; Break'


# Set title, theme and display a greeting
$Host.UI.RawUI.WindowTitle = "SymLink Creation Tool ($version)"
Invoke-Expression $theme
Write-Host "`nWelcome to the SymLink Creation Tool.
`rFollow the instructions to create symlinks quickly and easily." -ForegroundColor White

# initialPath from which program takes the targetFolders and clientFolder as general intermediate path
$clientFolder = ".minecraft"
$initialPath = "$PSScriptRoot\$clientFolder"


# targetFolders array - you can put your values
$targetFolders = @(
    'resourcepacks'
)


# Read instancePath entered by user
while ($checkInput -ne $True) {
    $instancePath = Read-Host -Prompt "`nInput Instance Path (NOT '.minecraft' folder - one level above)`n"
    if ((Get-ChildItem -Path "$instancePath" -Name "instance.cfg" -ErrorAction Ignore) -eq "instance.cfg") {
        $checkInput = $True
        Write-Host "The path is correct." -ForegroundColor Green
    } else {
        Write-Host "Instance Path must contain the 'instance.cfg' file.
        `rCheck the data and try again, or push 'Ctrl+C' for leave the program." -ForegroundColor Red
    }
}

# TODO: add the ability to specify 'folder\folder\target' in $targetFolders
# Define destinationPath
New-Item -Type Directory -Path "$instancePath" -Name "$clientFolder" -ErrorAction Ignore
$destinationPath = "$instancePath\$clientFolder"

# Check a duplicate directory..
foreach ($folder in $targetFolders) {
    if ((Get-ChildItem -Path "$destinationPath" -Name "$folder") -like '*') {
        $findDuplicates = $True
        Write-Host "Find a duplicate for '$folder' directory!" -ForegroundColor Yellow
    }
}
if ($findDuplicates) {
    # ..ask for removing..
    $resolve = Read-Host -Prompt "`nDelete the duplicates automatically? [Y/N]"
    if ($resolve -eq 'Y') {
        # ..and directly remove
        foreach ($folder in $targetFolders) {
            Remove-Item -Path "$destinationPath\$folder" -ErrorAction Ignore
        }
    } else {
        # If the user refuses, let him delete them manually
        Write-Host "`nCreation SymLinks was stopped. Delete duplicates manually and start the program again." -ForegroundColor Red
        Invoke-Expression $exit
    }
}

# Create the necessary SymLinks
foreach ($folder in $targetFolders) {
    New-Item -ItemType SymbolicLink -Target "$initialPath\$folder" -Path "$destinationPath\$folder" -ErrorAction SilentlyContinue
}

# TODO: do a check via -ErrorVariable instead of $Error
if ($Error -like '*') {
    # The user refused to delete only part of the files when reconfirmed
    Write-Host "`nSome SymLinks were not created due to duplicates. Check the result manually." -ForegroundColor Yellow
    Invoke-Expression $exit
} else {
    # Notification of work successfully finished
    Write-Host "`nSymLinks created successfully." -ForegroundColor Green
    Invoke-Expression $exit
}
