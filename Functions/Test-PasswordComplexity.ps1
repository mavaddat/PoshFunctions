function Test-PasswordComplexity {
    <#
.SYNOPSIS
    Tests a password for length and password complexity
.DESCRIPTION
    Tests a password for length and password complexity. Complexity is at least 3 of the 4 classes of characters: upper case, lower case, numeral, special character.
.PARAMETER SecureString
    The password passed as a secure string. In parameter sets 'SecureString'.
.PARAMETER Credential
    The password passed as part of a credential. In parameter sets 'Credential'.
.PARAMETER Password
    The password passed as plain text. In parameter sets 'Password'.
.Parameter MinimumLength
    Integer minimum number of characters in password. Valid range 1-255. Defaults to 8. Aliased to 'MinLength'.
    In parameter sets 'SecureString', 'Credential', 'Password'
.PARAMETER IncludeInput
    Switch whether to include input in the output. Passwords are masked with a '*'. In parameter sets 'SecureString', 'Credential', 'Password'
.EXAMPLE
    Test-PasswordComplexity -Password 'Password1'

    Would return $true as there are 3 classes of characters (excluding special characters)
.EXAMPLE
    Test-PasswordComplexity -Password 'Password1' -IncludeInput

    Would return the following as it matches 3 of the 4 character classes
    Password  MinLength Length MatchComplexity
    --------  --------- ------ ---------------
    *********         8      9           True
.EXAMPLE
    Test-PasswordComplexity -Password 'Ab(0' -IncludeInput

    Although it matches all the character types the password is too short
    Password MinLength Length MatchComplexity
    -------- --------- ------ ---------------
    ****             8      4           False
.NOTES
    Changed logic on getting $*Regex values so there would not be a dependency on Get-PrintableAscii
    Changed logic so only 3 of the 4 classes of characters need to be matched
#>

    #region Parameter
    [CmdletBinding(DefaultParameterSetName = 'SecureString')]
    [OutputType('bool')]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseOutputTypeCorrectly', '')]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    param (
        [Parameter(ParameterSetName = 'SecureString')]
        [securestring] $SecureString,

        [Parameter(ParameterSetName = 'Credential')]
        [pscredential] $Credential,

        [Parameter(ParameterSetName = 'Password', ValueFromPipeline)]
        [string[]] $Password,

        [Parameter(ParameterSetName = 'SecureString')]
        [Parameter(ParameterSetName = 'Credential')]
        [Parameter(ParameterSetName = 'Password')]
        [ValidateRange(1, 255)]
        [Alias('MinLength')]
        [int] $MinimumLength = 8,

        [Parameter(ParameterSetName = 'SecureString')]
        [Parameter(ParameterSetName = 'Credential')]
        [Parameter(ParameterSetName = 'Password')]
        [switch] $IncludeInput
    )
    #endregion

    begin {
        Write-Verbose -Message "Starting [$($MyInvocation.Mycommand)]"
        $Printable = (33..126 | ForEach-Object { ([regex]::Escape([char] $_ )) })
        $LowerRegex = '[a-z]'
        $UpperRegex = '[A-Z]'
        $NumberRegex = '[0-9]'
        $SpecialRegex = '[' + (($Printable | Where-Object { $_ -notmatch $LowerRegex -and $_ -notmatch $NumberRegex } ) -join '|') + ']'
    }

    process {
        switch ($PsCmdlet.ParameterSetName) {
            'Password' {
                foreach ($curPassword in $Password) {
                    if (
                        ($curPassword.Length -ge $MinimumLength) -and (
                            ( $curPassword -match $SpecialRegex -and $curPassword -cmatch $LowerRegex -and $curPassword -cmatch $UpperRegex ) -or
                            ( $curPassword -match $SpecialRegex -and $curPassword -cmatch $LowerRegex -and $curPassword -match $NumberRegex) -or
                            ( $curPassword -match $SpecialRegex -and $curPassword -cmatch $UpperRegex -and $curPassword -match $NumberRegex) -or
                            ( $curPassword -cmatch $LowerRegex -and $curPassword -cmatch $UpperRegex -and $curPassword -match $NumberRegex)
                        )
                    ) {
                        $ReturnVal = $true
                    } else {
                        $ReturnVal = $false
                    }
                    if ($IncludeInput) {
                        New-Object -TypeName psobject -Property ([ordered] @{
                                Password        = $curPassword -replace '.', '*'
                                MinLength       = $MinimumLength
                                Length          = $curPassword.Length
                                MatchComplexity = $ReturnVal
                            })
                    } else {
                        $ReturnVal
                    }
                }
            }
            'Credential' {
                $curPassword = Convert-SecureStringToString -SecureString $Credential.Password
                if (
                    ($curPassword.Length -ge $MinimumLength) -and (
                        ( $curPassword -match $SpecialRegex -and $curPassword -cmatch $LowerRegex -and $curPassword -cmatch $UpperRegex ) -or
                        ( $curPassword -match $SpecialRegex -and $curPassword -cmatch $LowerRegex -and $curPassword -match $NumberRegex) -or
                        ( $curPassword -match $SpecialRegex -and $curPassword -cmatch $UpperRegex -and $curPassword -match $NumberRegex) -or
                        ( $curPassword -cmatch $LowerRegex -and $curPassword -cmatch $UpperRegex -and $curPassword -match $NumberRegex)
                    )
                ) {
                    $ReturnVal = $true
                } else {
                    $ReturnVal = $false
                }
                if ($IncludeInput) {
                    New-Object -TypeName psobject -Property ([ordered] @{
                            Password        = $curPassword -replace '.', '*'
                            MinLength       = $MinimumLength
                            Length          = $curPassword.Length
                            MatchComplexity = $ReturnVal
                        })
                } else {
                    $ReturnVal
                }

            }
            'SecureString' {
                $curPassword = Convert-SecureStringToString -SecureString $SecureString
                if (
                    ($curPassword.Length -ge $MinimumLength) -and (
                        ( $curPassword -match $SpecialRegex -and $curPassword -cmatch $LowerRegex -and $curPassword -cmatch $UpperRegex ) -or
                        ( $curPassword -match $SpecialRegex -and $curPassword -cmatch $LowerRegex -and $curPassword -match $NumberRegex) -or
                        ( $curPassword -match $SpecialRegex -and $curPassword -cmatch $UpperRegex -and $curPassword -match $NumberRegex) -or
                        ( $curPassword -cmatch $LowerRegex -and $curPassword -cmatch $UpperRegex -and $curPassword -match $NumberRegex)
                    )
                ) {
                    $ReturnVal = $true
                } else {
                    $ReturnVal = $false
                }
                if ($IncludeInput) {
                    New-Object -TypeName psobject -Property ([ordered] @{
                            Password        = $curPassword -replace '.', '*'
                            MinLength       = $MinimumLength
                            Length          = $curPassword.Length
                            MatchComplexity = $ReturnVal
                        })
                } else {
                    $ReturnVal
                }
            }
        }

    }

    end {
        Write-Verbose -Message "Ending [$($MyInvocation.Mycommand)]"
    }
}
