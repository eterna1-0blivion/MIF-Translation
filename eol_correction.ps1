# author: eterna1_0blivion
$version = 'v1.1.10'

# Set title and display a caution
Clear-Host
$Host.UI.RawUI.WindowTitle = "End-of-Lines Correction Tool ($version)"
$Host.UI.RawUI.BackgroundColor = "Black"
$Host.UI.RawUI.ForegroundColor = "Gray"
Write-Host "`nPlease wait for the script to complete!" -ForegroundColor White

# Create gitBash alias (current for Windows only)
New-Alias -Name gitBash -Value "$Env:ProgramFiles\Git\bin\bash.exe"

# General commands for git
& gitBash -l -c 'git config --system core.autocrlf input'
& gitBash -l -c 'git config --system core.eol lf'

# Display a warning, because further action could lead to an undesirable result
Write-Host "`nWARNING! If there are any un-committed changes in your local repository, they might be removed due to errors!" -ForegroundColor Red
$resolve = Read-Host -Prompt "`nContinue EOL correction? [Y/N]"
if ($resolve -ne 'Y') {
    Write-Host "`nYou've stopped the script from running." -ForegroundColor Yellow
    Read-Host -Prompt "Press Enter to exit"
    Break
}

# Display an initial path
& gitBash -l -c 'cmd //c cd && echo Loading...'

# Commands to 'CR+LF' -> 'LF' convert
& gitBash -l -c 'git rm --cached -rf . && echo Loading...'
& gitBash -l -c 'git diff --cached --name-only -z | xargs -n 50 -0 git add -f'
& gitBash -l -c 'git ls-files -z | xargs -0 rm'
& gitBash -l -c 'git checkout .'

# Notification of successfully finished work
Write-Host "`nThe script completed successfully." -ForegroundColor Green
Read-Host -Prompt "Press Enter to exit"
Break
