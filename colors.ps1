# author: timabell && eterna1_0blivion

# Initial settings
Clear-Host
$Host.UI.RawUI.BackgroundColor = "Black"
$Host.UI.RawUI.ForegroundColor = "Gray"

# Define the order in the colors array
$colors = @( # [enum]::GetValues([System.ConsoleColor])
    'White'
    'Gray'
    'DarkGray'
    'Black'
    'DarkRed'
    'Red'
    'DarkYellow'
    'Yellow'
    'DarkGreen'
    'Green'
    'Cyan'
    'DarkCyan'
    'Blue'
    'DarkBlue'
    'Magenta'
    'DarkMagenta'
)

# Draw a table of colors
Foreach ($bgcolor in $colors) {
    Foreach ($fgcolor in $colors) {
        Write-Host "$fgcolor|" -ForegroundColor $fgcolor -BackgroundColor $bgcolor -NoNewLine
    }
    Write-Host " on $bgcolor"
}

# Notify the user before exiting the program
Read-Host -Prompt "Press Enter to exit"
Break
