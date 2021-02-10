#requires -Version 2 -Modules posh-git

function Write-Theme {
    param(
        [bool]
        $lastCommandFailed,
        [string]
        $with
    )
    
    if (Test-VirtualEnv) {
        $prompt += Write-Prompt -Object "$($sl.PromptSymbols.SegmentForwardSymbol) " -ForegroundColor $sl.Colors.SessionInfoBackgroundColor -BackgroundColor $sl.Colors.GreenColor
        $prompt += Write-Prompt -Object "$($sl.PromptSymbols.VirtualEnvSymbol) ($(Get-VirtualEnvName))" -ForegroundColor $sl.Colors.BlackColor -BackgroundColor $sl.Colors.GreenColor
        # $prompt += Write-Prompt -Object "$($sl.PromptSymbols.SegmentForwardSymbol) " -ForegroundColor $sl.Colors.SessionInfoBackgroundColor -BackgroundColor $sl.Colors.PromptBackgroundColor 
    }
    else {
        $prompt += Write-Prompt -Object "$($sl.PromptSymbols.SegmentForwardSymbol)" -ForegroundColor $sl.Colors.SessionInfoBackgroundColor -BackgroundColor $sl.Colors.PromptBackgroundColor
    }
    # write # and space
    $prompt = Write-Prompt -Object $sl.PromptSymbols.StartSymbol -ForegroundColor $sl.Colors.PromptHighlightColor
    # write user
    $user = $sl.CurrentUser
    if (Test-NotDefaultUser($user)) {
        # $prompt += Write-Prompt -Object "(" -ForegroundColor $sl.Colors.BracketColor
        $prompt += Write-Prompt -Object "$user" -ForegroundColor $sl.Colors.PromptHighlightColor
        # $prompt += Write-Prompt -Object ")" -ForegroundColor $sl.Colors.BracketColor

        # write at (devicename)
        # $computer = $sl.CurrentHostname
        # $prompt += Write-Prompt -Object " at" -ForegroundColor $sl.Colors.PromptForegroundColor
        # $prompt += Write-Prompt -Object " $computer" -ForegroundColor $sl.Colors.GitDefaultColor
        # # write in for folder
        $prompt += Write-Prompt -Object " in " -ForegroundColor $sl.Colors.PromptForegroundColor
    }
    # write folder
    $prompt += Write-Prompt -Object "$(Get-ShortPath -dir $pwd) " -ForegroundColor $sl.Colors.DriveForegroundColor

    $status = Get-VCSStatus
    if ($status) {
        if ($status.Working.Length -gt 0) {
            $prompt += Write-Prompt -Object ("" + $sl.PromptSymbols.GitDirtyIndicator) -ForegroundColor $sl.Colors.GitDefaultColor
        }
        $themeInfo = Get-VcsInfo -status ($status)
        $info = "$($themeInfo.VcInfo)".Split(" ")[1].TrimStart()
        $prompt += Write-Prompt -Object "on " -ForegroundColor $sl.Colors.PromptForegroundColor  
        $prompt += Write-Prompt -Object "$($sl.GitSymbols.BranchSymbol+' ')" -ForegroundColor $sl.Colors.GitDefaultColor
        $prompt += Write-Prompt -Object "Git(" -ForegroundColor $sl.Colors.BracketColor
        $prompt += Write-Prompt -Object "$($status.Branch)" -ForegroundColor $sl.Colors.GitDefaultColor
        $prompt += Write-Prompt -Object ")" -ForegroundColor $sl.Colors.BracketColor

        # $prompt += Write-Prompt -Object " [$($info)]" -ForegroundColor $sl.Colors.PromptHighlightColor
        # $filename = 'package.json'
        # if (Test-Path -path $filename) {
        #     $prompt += Write-Prompt -Object (" via node") -ForegroundColor $sl.Colors.PromptSymbolColor
        # }
    }

    # check for elevated prompt
    If (Test-Administrator) {
        $prompt += Write-Prompt -Object "$($sl.PromptSymbols.ElevatedSymbol) " -ForegroundColor $sl.Colors.AdminIconForegroundColor
    }
    # check the last command state and indicate if failed
    $foregroundColor = $sl.Colors.PromptHighlightColor
    If ($lastCommandFailed) {
        $foregroundColor = $sl.Colors.CommandFailedIconForegroundColor
    }

    if ($with) {
        $prompt += Write-Prompt -Object "$($with.ToUpper()) " -BackgroundColor $sl.Colors.WithBackgroundColor -ForegroundColor $sl.Colors.WithForegroundColor
    }

    $prompt += Set-Newline
    $prompt += Write-Prompt -Object $sl.PromptSymbols.PromptIndicator -ForegroundColor $foregroundColor
    $prompt += ' '
    $prompt
}

function Get-TimeSinceLastCommit {
    return (git log --pretty=format:'%cr' -1)
}

$sl = $global:ThemeSettings #local settings
$sl.PromptSymbols.GitDirtyIndicator =[char]::ConvertFromUtf32(10007)
$sl.GitSymbols.BranchSymbol = [char]::ConvertFromUtf32(0xE0A0)

$sl.PromptSymbols.PromptIndicator = [char]::ConvertFromUtf32(0x279C)

$sl.PromptSymbols.StartSymbol = " # "

$sl.Colors.PromptHighlightColor = [ConsoleColor]::DarkBlue
$sl.Colors.PromptForegroundColor = [ConsoleColor]::White
$sl.Colors.PromptHighlightColor = [ConsoleColor]::DarkBlue
$sl.Colors.WithForegroundColor = [ConsoleColor]::DarkRed
$sl.Colors.WithBackgroundColor = [ConsoleColor]::Magenta
$sl.Colors.BracketColor = [ConsoleColor]::Red 
$sl.Colors.GreenColor = [ConsoleColor]::Green 
$sl.Colors.BlackColor = [ConsoleColor]::Black 



# $sl.Colors.VirtualEnvForegroundColor = [ConsoleColor]::DarkRed
$sl.Colors.VirtualEnvBackgroundColor = [System.ConsoleColor]::Red
$sl.Colors.VirtualEnvForegroundColor = [System.ConsoleColor]::White