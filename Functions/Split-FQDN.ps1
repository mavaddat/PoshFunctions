Function Split-FQDN {
    <#
.SYNOPSIS
    To split a FQDN string line by into its constituent parts which are separated by a '.'
.DESCRIPTION
    To split a FQDN string line by into its constituent parts which are separated by a '.'
.PARAMETER FQDN
    The FQDN string you want to parse. Can be single string or array of strings. Values can be passed
    via the pipeline as straight text or via property name. Aliased to 'hostname'
.PARAMETER Parent
    Switch to display the parent of the distinguished name. Default parameter
.PARAMETER Leaf
    Switch to display the leaf of the distinguished name
.PARAMETER Token
    Switch to return an array of all the parts
.EXAMPLE
    Split-FQDN -FQDN 'server1.contosco.com'

    server1.contosco.com
.EXAMPLE
    Split-FQDN -FQDN 'server1.contosco.com' -Leaf

    server1
.EXAMPLE
    'server1.contosco.com' | Split-FQDN

    contosco.com
.EXAMPLE
    'server1.contosco.com' | Split-FQDN -Leaf

    server1
#>

    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter','')]
    [CmdletBinding(ConfirmImpact = 'None', DefaultParameterSetName = 'Parent')]
    [OutputType('string[]')]
    param(
        [Parameter(Mandatory, HelpMessage = 'Enter a string composed of tokens separated by a /', Position = 0, ValueFromPipeline, ValueFromPipelineByPropertyName, ParameterSetName = 'Parent')]
        [Parameter(Mandatory, HelpMessage = 'Enter a string composed of tokens separated by a /', Position = 0, ValueFromPipeline, ValueFromPipelineByPropertyName, ParameterSetName = 'Leaf')]
        [Parameter(Mandatory, HelpMessage = 'Enter a string composed of tokens separated by a /', Position = 0, ValueFromPipeline, ValueFromPipelineByPropertyName, ParameterSetName = 'Token')]
        [Alias('HostName')]
        [string[]] $FQDN,

        [Parameter(ParameterSetName = 'Parent')]
        [switch] $Parent,

        [Parameter(ParameterSetName = 'Leaf')]
        [switch] $Leaf,

        [Parameter(ParameterSetName = 'Token')]
        [switch] $Token
    )

    begin {
        Write-Verbose -Message "Starting [$($MyInvocation.Mycommand)]"
    }

    process {
        foreach ($item in $FQDN) {
            $tmpArray = $item -split '\.'
            switch ($PsCmdlet.ParameterSetName) {
                'Leaf' {
                    $tmpArray[0]
                }
                'Parent' {
                    if ($tmpArray.Count -gt 1) {
                        $tmpArray[1..($tmpArray.Count - 1)] -join '.'
                    }
                }
                'Token' {
                    $tmpArray[0..($tmpArray.Count - 1)]
                }
            }
        }
    }

    end {
        Write-Verbose -Message "Ending [$($MyInvocation.Mycommand)]"
    }

}
