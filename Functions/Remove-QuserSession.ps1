function Remove-QuserSession {
    <#
    .SYNOPSIS
        Resets a user session via rwinsta.exe, resolved through Get-QuserSession.

    .DESCRIPTION
        Looks up a matching session with Get-QuserSession (by UserName, SessionName, or Id)
        and, if found and not the session initiating the call, resets it with rwinsta.exe.
        A session flagged as the CurrentUser session is never reset - the function emits a
        non-terminating error and moves on rather than tearing down its own session.

    .PARAMETER UserName
        The UserName to match against Get-QuserSession output. Default parameter set.

    .PARAMETER SessionName
        The SessionName to match against Get-QuserSession output.

    .PARAMETER Id
        The session Id to match against Get-QuserSession output.

    .PARAMETER ComputerName
        The remote computer to operate against. Passed to both Get-QuserSession and as
        '/server:<ComputerName>' to rwinsta.exe. If omitted, the local computer is used.

    .PARAMETER Force
        Suppresses the ShouldProcess confirmation prompt that ConfirmImpact = 'High' would
        otherwise trigger. -WhatIf still short-circuits the action even with -Force.

    .EXAMPLE
        Remove-QuserSession -UserName jdoe

        Resets jdoe's session on the local computer.

    .EXAMPLE
        Remove-QuserSession -SessionName 'rdp-tcp#3' -ComputerName SQL01

        Resets the session named 'rdp-tcp#3' on SQL01.

    .EXAMPLE
        Remove-QuserSession -Id 2 -ComputerName SQL01 -WhatIf

        Shows what would happen if session Id 2 on SQL01 were reset, without doing it.

    .EXAMPLE
        Remove-QuserSession -UserName jdoe -ComputerName SQL01 -Force

        Resets jdoe's session on SQL01 without prompting for confirmation.
    #>
    [CmdletBinding(DefaultParameterSetName = 'UserName', SupportsShouldProcess, ConfirmImpact = 'High')]
    param(
        [Parameter(ParameterSetName = 'UserName', Position = 0, Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string] $UserName,

        [Parameter(ParameterSetName = 'SessionName', Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string] $SessionName,

        [Parameter(ParameterSetName = 'Id', Mandatory)]
        [ValidateNotNullOrEmpty()]
        [int] $Id,

        [Parameter()]
        [Alias('CN', 'Server')]
        [ValidateNotNullOrEmpty()]
        [string] $ComputerName,

        [Parameter()]
        [switch] $Force
    )

    begin {
        Write-Verbose -Message "[$($MyInvocation.MyCommand)] Function started"

        if ($Force -and -not $PSBoundParameters.ContainsKey('Confirm')) {
            Write-Verbose -Message "[$($MyInvocation.MyCommand)] -Force specified, suppressing confirmation prompts"
            $ConfirmPreference = 'None'
        }
    }

    process {
        $getQuserSessionParams = @{}
        if ($ComputerName) {
            $getQuserSessionParams['ComputerName'] = $ComputerName
        }

        $sessions = Get-QuserSession @getQuserSessionParams

        if (-not $sessions) {
            Write-Verbose -Message "[$($MyInvocation.MyCommand)] Get-QuserSession returned no sessions"
            return
        }

        switch ($PSCmdlet.ParameterSetName) {
            'UserName' {
                $matchingSessions = @($sessions | Where-Object { $_.UserName -eq $UserName })
                $criteriaDescription = "UserName '$UserName'"
            }
            'SessionName' {
                $matchingSessions = @($sessions | Where-Object { $_.SessionName -eq $SessionName })
                $criteriaDescription = "SessionName '$SessionName'"
            }
            'Id' {
                $matchingSessions = @($sessions | Where-Object { $_.Id -eq $Id })
                $criteriaDescription = "Id '$Id'"
            }
        }

        if ($matchingSessions.Count -eq 0) {
            Write-Verbose -Message "[$($MyInvocation.MyCommand)] No matching session found for $criteriaDescription"
            return
        }

        foreach ($session in $matchingSessions) {
            $target = "SessionId $($session.Id) ('$($session.UserName)') on '$($session.ComputerName)'"

            if ($session.CurrentUser) {
                Write-Error -Message "[$($MyInvocation.MyCommand)] Refusing to reset $target because it is the current user's session"
                continue
            }

            if ($PSCmdlet.ShouldProcess($target, 'Reset session (rwinsta.exe)')) {
                if ($ComputerName) {
                    Write-Verbose -Message "[$($MyInvocation.MyCommand)] Running rwinsta.exe /server:$ComputerName $($session.Id)"
                    $rwinstaOutput = rwinsta.exe /server:$ComputerName $session.Id 2>&1
                }
                else {
                    Write-Verbose -Message "[$($MyInvocation.MyCommand)] Running rwinsta.exe $($session.Id)"
                    $rwinstaOutput = rwinsta.exe $session.Id 2>&1
                }

                if ($LASTEXITCODE -ne 0) {
                    Write-Error -Message "[$($MyInvocation.MyCommand)] rwinsta.exe failed for $target : $($rwinstaOutput -join ' ')"
                }
            }
        }
    }

    end {
        Write-Verbose -Message "[$($MyInvocation.MyCommand)] Function ended"
    }
}
