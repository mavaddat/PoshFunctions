function New-RandomPassword {
    <#
.SYNOPSIS
    Creates a new random password
.DESCRIPTION
    Creates a new random password. Parameters can be passed to determine minimum and maximum password lengths, whether to avoid characters that are similar to one another or to limit it to readable words. Please read .NOTES section.
.PARAMETER MinLength
    Integer representing minimum password length, valid range 8-102 characters. ParameterSetName: ReadableTitleCase, ReadableRandomCase, Web
.PARAMETER MaxLength
    Integer representing maximum password length, valid range 8-102 characters. ParameterSetName: ReadableTitleCase, ReadableRandomCase, Web
.PARAMETER NonAlphaChars
    Integer representing the number of non alphabetic characters. ParameterSetName: Web
.PARAMETER Readable
    Switch indicating to use combinations of English words. Default behavior is to output a words that are title cased. ParameterSetName: ReadableTitleCase, ReadableRandomCase
.PARAMETER AvoidSimilar
    Switch to prevent characters that are similar to one another to be included. For instance 1, l, I. ParameterSetName: ReadableTitleCase, ReadableRandomCase, Web
.PARAMETER TitleCase
    Switch to capitalize each word. ParameterSetName: ReadableTitleCase
.PARAMETER RandomCase
    Switch to randomly capitalize letters in each word. ParameterSetName: ReadableRandomCase
.PARAMETER Web
    Switch to use web algorithm. ParameterSetName: Web
.PARAMETER FullWordList
    Switch to use full word list of 370,103 words vs. 38,000 words
.EXAMPLE
    New-RandomPassword -Web

    wtV%R:K-uIn]
.EXAMPLE
    New-RandomPassword -MinLength 16 -AvoidSimilar

    4,UnsureParFeuds
.EXAMPLE
    New-RandomPassword -Readable -MinLength 8 -RandomCase

    .7dArTer
.EXAMPLE
    New-RandomPassword -MinLength 16 -AvoidSimilar -Web

    U6V:3a5^kEGHU:!7
.EXAMPLE
    New-RandomPassword -MinLength 16 -MaxLength 20 -Readable -AvoidSimilar

    Nicer6Jeer)Linger
.NOTES
    Changes:

    Added -TitleCase switch so that each word is capitalized
    Added -RandomCase switch so that each letter is randomly capitalized
    Added -Web switch so that web algorithm is used
    Changed parameter set names to more accurately reflect what they do
    Updated help comments
    DefaultParameterSetName is 'ReadableTitleCase'
#>

    #region parameter
    [CmdletBinding(DefaultParameterSetName = 'ReadableTitleCase', ConfirmImpact = 'None')]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', '')]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions', '')]
    [OutputType('string')]
    Param (

        [Parameter(ParameterSetName = 'Web')]
        [Parameter(ParameterSetName = 'ReadableRandomCase')]
        [Parameter(ParameterSetName = 'ReadableTitleCase')]
        [ValidateRange(8, 102)]
        [int] $MinLength = 12,

        [Parameter(ParameterSetName = 'Web')]
        [Parameter(ParameterSetName = 'ReadableTitleCase')]
        [Parameter(ParameterSetName = 'ReadableRandomCase')]
        [ValidateRange(8, 102)]
        [int] $MaxLength,

        [Parameter(ParameterSetName = 'Web')]
        [int] $NonAlphaChars,

        [Parameter(ParameterSetName = 'ReadableTitleCase')]
        [Parameter(ParameterSetName = 'ReadableRandomCase')]
        [switch] $Readable,

        [Parameter(ParameterSetName = 'Web')]
        [Parameter(ParameterSetName = 'ReadableTitleCase')]
        [Parameter(ParameterSetName = 'ReadableRandomCase')]
        [switch] $AvoidSimilar,

        [Parameter(ParameterSetName = 'ReadableTitleCase')]
        [switch] $TitleCase,

        [Parameter(ParameterSetName = 'ReadableRandomCase')]
        [switch] $RandomCase,

        [Parameter(ParameterSetName = 'Web')]
        [switch] $Web,

        [Parameter(ParameterSetName = 'ReadableTitleCase')]
        [Parameter(ParameterSetName = 'ReadableRandomCase')]
        [switch] $FullWordList
    )
    #endregion parameter

    begin {
        Write-Verbose -Message "Starting [$($MyInvocation.Mycommand)]"
        Write-Verbose -Message "ParameterSetName [$($PsCmdlet.ParameterSetName)]"
        $SimilarRegex = '\+|''|\-|0|1|I|O|_|`|l|o|t|\|'
        Write-Verbose -Message "SimilarRegex = [$SimilarRegex]"
        if (-not $MaxLength) {
            $MaxLength = $MinLength
        }
        switch ($PsCmdlet.ParameterSetName) {
            'Web' {
            }
            'ReadableTitleCase' {
                $Symbol = Get-PrintableAscii -Verbose:$false | Where-Object { $_.Class -eq 's' }
                $MaxWords = [int] ($MaxLength / 3)
                $MinWords = [int] ($MinLength / 6)
                $Words = Get-WordList -Full:$FullWordList -Verbose:$false | Where-Object { $_.Length -ge 3 -and $_.Length -le 6 }
                $Sample = $Words | Get-Random -Count ($MinWords * 30) -Verbose:$false | Format-TitleCase -Verbose:$false
            }
            'ReadableRandomCase' {
                $Symbol = Get-PrintableAscii -Verbose:$false | Where-Object { $_.Class -eq 's' }
                $MaxWords = [int] ($MaxLength / 3)
                $MinWords = [int] ($MinLength / 6)
                $Words = Get-WordList -Full:$FullWordList -Verbose:$false | Where-Object { $_.Length -ge 3 -and $_.Length -le 6 }
                $Sample = $Words | Get-Random -Count ($MinWords * 30) -Verbose:$false | Format-RandomCase -Verbose:$false
            }
        }
    }

    process {
        switch ($PsCmdlet.ParameterSetName) {
            'Web' {
                if (-not $NonAlphaChars) {
                    $NonAlphaChars = 0
                }
                if ($MinLength -eq $MaxLength) {
                    $Length = $MinLength
                } else {
                    $Length = Get-Random -Minimum $MinLength -Maximum ($MaxLength + 1)
                }
                do {
                    if (-not $AvoidSimilar) {
                        $ReturnVal = [System.Web.Security.Membership]::GeneratePassword($Length, $nonAlphaChars)
                        Write-Verbose -Message "PW is [$ReturnVal]"
                    } else {
                        do {
                            Write-Verbose -Message 'in do'
                            $ReturnVal = [System.Web.Security.Membership]::GeneratePassword($Length, $nonAlphaChars)
                            Write-Verbose -Message "PW is [$ReturnVal]"
                        } until (-not ($ReturnVal -cmatch $SimilarRegex))
                    }
                } until (($ReturnVal.Length -ge $MinLength) -and ($ReturnVal.Length -le $MaxLength))
                $ReturnVal
            }
            'ReadableTitleCase' {
                do {
                    if (-not $AvoidSimilar) {
                        $RandomSymbol = $Symbol.Char | Get-Random -Verbose:$false
                        $RandomDigit = 0..9 | Get-Random -Verbose:$false
                        $curWords = Get-Random -Minimum $MinWords -Maximum ($MaxWords + 1) -Verbose:$false
                        Write-Verbose -Message "Symbol [$RandomSymbol] Digit [$RandomDigit]"
                        $ReturnVal = ( @(($Sample | Get-Random -Count $curWords -Verbose:$false), $RandomDigit, $RandomSymbol) | Get-Random -Count ($curWords + 2)) -join ''
                    } else {
                        $RandomSymbol = $Symbol.Char | Where-Object { -not ($_ -cmatch $SimilarRegex) } | Get-Random -Verbose:$false
                        $RandomDigit = 0..9 | Where-Object { -not ($_ -cmatch $SimilarRegex) } | Get-Random -Verbose:$false
                        $curWords = Get-Random -Minimum $MinWords -Maximum ($MaxWords + 1) -Verbose:$false
                        $Sample = $Sample | Where-Object { -not ($_ -cmatch $SimilarRegex) }
                        $ReturnVal = ( @(($Sample | Get-Random -Count $curWords -Verbose:$false), $RandomDigit, $RandomSymbol) | Get-Random -Count ($curWords + 2)) -join ''
                    }
                } until (($ReturnVal.Length -ge $MinLength) -and ($ReturnVal.Length -le $MaxLength))
                $ReturnVal
            }
            'ReadableRandomCase' {
                do {
                    if (-not $AvoidSimilar) {
                        $RandomSymbol = $Symbol.Char | Get-Random -Verbose:$false
                        $RandomDigit = 0..9 | Get-Random -Verbose:$false
                        $curWords = Get-Random -Minimum $MinWords -Maximum ($MaxWords + 1) -Verbose:$false
                        Write-Verbose -Message "Symbol [$RandomSymbol] Digit [$RandomDigit]"
                        $ReturnVal = ( @(($Sample | Get-Random -Count $curWords -Verbose:$false), $RandomDigit, $RandomSymbol) | Get-Random -Count ($curWords + 2)) -join ''
                    } else {
                        $RandomSymbol = $Symbol.Char | Where-Object { -not ($_ -cmatch $SimilarRegex) } | Get-Random -Verbose:$false
                        $RandomDigit = 0..9 | Where-Object { -not ($_ -cmatch $SimilarRegex) } | Get-Random -Verbose:$false
                        $curWords = Get-Random -Minimum $MinWords -Maximum ($MaxWords + 1) -Verbose:$false
                        $Sample = $Sample | Where-Object { -not ($_ -cmatch $SimilarRegex) }
                        $ReturnVal = ( @(($Sample | Get-Random -Count $curWords -Verbose:$false), $RandomDigit, $RandomSymbol) | Get-Random -Count ($curWords + 2)) -join ''
                    }
                } until (($ReturnVal.Length -ge $MinLength) -and ($ReturnVal.Length -le $MaxLength))
                $ReturnVal
            }
        }
    }

    end {
        Write-Verbose -Message "Ending [$($MyInvocation.Mycommand)]"
    }
}
