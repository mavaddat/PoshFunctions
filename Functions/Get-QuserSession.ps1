function Get-QuserSession {
    <#
    .SYNOPSIS
        Parses the output of quser.exe into structured objects.

    .DESCRIPTION
        Runs quser.exe (optionally against a remote server via -ComputerName) and parses
        the fixed-width console output into properly typed properties instead of raw text.

    .PARAMETER ComputerName
        The remote computer to query with 'quser.exe /server:<ComputerName>'. If omitted,
        quser.exe is run against the local computer.

    .EXAMPLE
        Get-QuserSession

        Lists logged on sessions on the local computer.

    .EXAMPLE
        Get-QuserSession -ComputerName SQL01

        Lists logged on sessions on SQL01.

    .EXAMPLE
        'SQL01','SQL02' | Get-QuserSession

        Lists logged on sessions on each computer name piped in.

    .OUTPUTS
        PoshFunctions.QuserSession
    #>
    [CmdletBinding()]
    [OutputType('PoshFunctions.QuserSession')]
    param(
        [Parameter(Position = 0, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [Alias('CN', 'Server')]
        [ValidateNotNullOrEmpty()]
        [string] $ComputerName
    )

    begin {
        Write-Verbose -Message "[$($MyInvocation.MyCommand)] Function started"
    }

    process {
        if ($ComputerName) {
            Write-Verbose -Message "[$($MyInvocation.MyCommand)] Running quser.exe /server:$ComputerName"
            $quserOutput = quser.exe /server:$ComputerName 2>&1
        }
        else {
            Write-Verbose -Message "[$($MyInvocation.MyCommand)] Running quser.exe against local computer"
            $quserOutput = quser.exe 2>&1
        }

        if ($LASTEXITCODE -ne 0) {
            # quser.exe exits non-zero with 'No User exists for *' when nobody is logged on -
            # that's an empty result, not a failure, so don't surface it as an error.
            if (($quserOutput -join ' ') -match 'No User exists for') {
                Write-Verbose -Message "[$($MyInvocation.MyCommand)] No sessions returned (quser.exe reported no users)"
                return
            }

            Write-Error -Message "[$($MyInvocation.MyCommand)] quser.exe failed: $($quserOutput -join ' ')"
            return
        }

        if (-not $quserOutput -or $quserOutput.Count -lt 2) {
            Write-Verbose -Message "[$($MyInvocation.MyCommand)] No sessions returned"
            return
        }

        # Column positions are derived from the header row so parsing survives
        # varying username/sessionname widths.
        $header = $quserOutput[0]

        $idxSessionName = $header.IndexOf('SESSIONNAME')
        $idxId          = $header.IndexOf('ID', $idxSessionName)
        $idxState       = $header.IndexOf('STATE', $idxId)
        $idxIdleTime    = $header.IndexOf('IDLE TIME', $idxState)
        $idxLogonTime   = $header.IndexOf('LOGON TIME', $idxIdleTime)

        if (($idxSessionName, $idxId, $idxState, $idxIdleTime, $idxLogonTime) -contains -1) {
            Write-Error -Message "[$($MyInvocation.MyCommand)] Unable to parse quser.exe header row: '$header'"
            return
        }

        $resolvedComputerName = if ($ComputerName) { $ComputerName } else { $env:COMPUTERNAME }

        foreach ($line in $quserOutput | Select-Object -Skip 1) {
            if ([string]::IsNullOrWhiteSpace($line)) {
                continue
            }

            # Pad in case trailing columns (e.g. LOGON TIME) are short/missing.
            $paddedLine = $line.PadRight($idxLogonTime)

            $currentUserChar = $paddedLine.Substring(0, 1)
            $userName        = $paddedLine.Substring(1, $idxSessionName - 1).Trim()
            $sessionName     = $paddedLine.Substring($idxSessionName, $idxId - $idxSessionName).Trim()
            $idRaw           = $paddedLine.Substring($idxId, $idxState - $idxId).Trim()
            $state           = $paddedLine.Substring($idxState, $idxIdleTime - $idxState).Trim()
            $idleTimeRaw     = $paddedLine.Substring($idxIdleTime, $idxLogonTime - $idxIdleTime).Trim()
            $logonTimeRaw    = $line.Substring([Math]::Min($idxLogonTime, $line.Length)).Trim()

            # --- IDLE TIME -> nullable [timespan] ---
            # quser reports '.' for < 1 minute, 'none' for never, 'mm', 'h:mm', or 'd+h:mm'.
            $idleTime = $null
            switch -Regex ($idleTimeRaw) {
                '^\.?$' {
                    $idleTime = [timespan]::Zero
                    break
                }
                '^none$' {
                    $idleTime = $null
                    break
                }
                '^(?<Days>\d+)\+(?<Hours>\d{1,2}):(?<Minutes>\d{2})$' {
                    $idleTime = New-TimeSpan -Days $Matches.Days -Hours $Matches.Hours -Minutes $Matches.Minutes
                    break
                }
                '^(?<Hours>\d{1,2}):(?<Minutes>\d{2})$' {
                    $idleTime = New-TimeSpan -Hours $Matches.Hours -Minutes $Matches.Minutes
                    break
                }
                '^\d+$' {
                    $idleTime = New-TimeSpan -Minutes ([int] $idleTimeRaw)
                    break
                }
                default {
                    Write-Verbose -Message "[$($MyInvocation.MyCommand)] Unrecognized IDLE TIME value '$idleTimeRaw' for '$userName'"
                    $idleTime = $null
                }
            }

            # --- LOGON TIME -> [datetime] ---
            $logonTime = $null
            if ($logonTimeRaw) {
                try {
                    $logonTime = [datetime] $logonTimeRaw
                }
                catch {
                    Write-Verbose -Message "[$($MyInvocation.MyCommand)] Unable to parse LOGON TIME value '$logonTimeRaw' for '$userName'"
                }
            }

            [pscustomobject] @{
                PSTypeName   = 'PoshFunctions.QuserSession'
                UserName     = $userName
                SessionName  = $sessionName
                Id           = if ($idRaw) { [int] $idRaw } else { $null }
                State        = $state
                IdleTime     = $idleTime
                LogonTime    = $logonTime
                CurrentUser  = $currentUserChar -eq '>'
                ComputerName = $resolvedComputerName
            }
        }
    }

    end {
        Write-Verbose -Message "[$($MyInvocation.MyCommand)] Function ended"
    }
}
