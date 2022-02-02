function Get-FileEncoding
{
    <#
.SYNOPSIS
    To get the file encoding of a file
.DESCRIPTION
    To get the file encoding of a file
.PARAMETER Path
    The file that you want to check its encoding.
.EXAMPLE
    Get-FileEncoding -Path .\UTF16-BigEndian.txt

    Unicode UTF-16 Big-Endian
.EXAMPLE
    Get-FileEncoding -Path .\UTF16-LittleEndian.txt

    Unicode UTF-16 Little-Endian
.NOTES
    # source: https://gist.github.com/jpoehls/2406504
#>

    [CmdletBinding()]
    Param (
        [Parameter(Mandatory, HelpMessage = 'Please enter the path to a file', ValueFromPipelineByPropertyName)]
        [string] $Path
    )

    begin
    {
        Write-Verbose -Message "Starting [$($MyInvocation.Mycommand)]"
    }

    process
    {
        if (Test-Path -Path $Path)
        {
            # Convert the file to a byte array
            $ByteArray = [System.IO.File]::ReadAllBytes($Path)
            
            if ( $ByteArray[0] -eq 0xef -and $ByteArray[1] -eq 0xbb -and $ByteArray[2] -eq 0xbf )
            {
                # EF BB BF (UTF8)
                Writer-Verbose "Detected encoding 'UTF8'"
                Write-Output -InputObject [System.Text.Encoding]::UTF8
            }
            elseif ($ByteArray[0] -eq 0xfe -and $ByteArray[1] -eq 0xff)
            {
                # FE FF  (UTF-16 Big-Endian)
                Writer-Verbose "Detected encoding 'Unicode UTF-16 Big-Endian'"
                Write-Output -InputObject [System.Text.Encoding]::BigEndianUnicode
            }
            elseif ($ByteArray[0] -eq 0xff -and $ByteArray[1] -eq 0xfe)
            {
                # FF FE  (UTF-16 Little-Endian)
                Writer-Verbose "Detected encoding 'Unicode UTF-16 Little-Endian'"
                Write-Output -InputObject [System.Text.Encoding]::Unicode
            }
            elseif ($ByteArray[0] -eq 0 -and $ByteArray[1] -eq 0 -and $ByteArray[2] -eq 0xfe -and $ByteArray[3] -eq 0xff)
            {
                # 00 00 FE FF (UTF32 Big-Endian)
                Writer-Verbose "Detected encoding 'UTF32 Big-Endian'"
                Write-Output -InputObject [System.Text.UTF32Encoding]::BigEndianUnicode
            }
            elseif ($ByteArray[0] -eq 0xfe -and $ByteArray[1] -eq 0xff -and $ByteArray[2] -eq 0 -and $ByteArray[3] -eq 0)
            {
                # FE FF 00 00 (UTF32 Little-Endian)
                Writer-Verbose "Detected encoding 'UTF32 Little-Endian'"
                Write-Output -InputObject [System.Text.Encoding]::UTF32
            }
            elseif ($ByteArray[0] -eq 0x2b -and $ByteArray[1] -eq 0x2f -and $ByteArray[2] -eq 0x76 -and ($ByteArray[3] -eq 0x38 -or $ByteArray[3] -eq 0x39 -or $ByteArray[3] -eq 0x2b -or $ByteArray[3] -eq 0x2f) )
            {
                # 2B 2F 76 (38 | 38 | 2B | 2F)
                Writer-Verbose "Detected encoding 'UTF7'"
                Write-Output -InputObject [System.Text.Encoding]::UTF7
            }
            elseif ( $ByteArray[0] -eq 0xf7 -and $ByteArray[1] -eq 0x64 -and $ByteArray[2] -eq 0x4c )
            {
                # F7 64 4C (UTF-1)
                Writer-Verbose "Detected encoding 'UTF-1'"
                Write-Output -InputObject 
            }
            elseif ($ByteArray[0] -eq 0xdd -and $ByteArray[1] -eq 0x73 -and $ByteArray[2] -eq 0x66 -and $ByteArray[3] -eq 0x73)
            {
                # DD 73 66 73 (UTF-EBCDIC)
                Writer-Verbose "Detected encoding 'UTF-EBCDIC'"
                Write-Output -InputObject [System.Text.Encoding]::GetEncoding(500)
            }
            elseif ( $ByteArray[0] -eq 0x0e -and $ByteArray[1] -eq 0xfe -and $ByteArray[2] -eq 0xff )
            {
                # 0E FE FF (SCSU)
                Writer-Verbose "Detected encoding 'SCSU'"
                Write-Output -InputObject [System.Text.Encoding]::GetEncoding(1013)
            }
            elseif ( $ByteArray[0] -eq 0xfb -and $ByteArray[1] -eq 0xee -and $ByteArray[2] -eq 0x28 )
            {
                # FB EE 28  (BOCU-1)
                Writer-Verbose "Detected encoding 'BOCU-1'"
                Write-Output -InputObject 'BOCU-1' # To precisely detect the binary compression requires complex deflate calculation
            }
            elseif ($ByteArray[0] -eq 0x84 -and $ByteArray[1] -eq 0x31 -and $ByteArray[2] -eq 0x95 -and $ByteArray[3] -eq 0x33)
            {
                # 84 31 95 33 (GB-18030)
                Writer-Verbose "Detected encoding 'GB-18030'"
                Write-Output -InputObject [System.Text.Encoding]::GetEncoding(54936)
            }
            else
            {
                Writer-Verbose "Detected encoding 'ASCII'"
                Write-Output -InputObject ([System.Text.Encoding]::ASCII)
            }
        }
        else
        {
            Write-Error -Message "The file [$Path] does not exist."
        }
    }

    end
    {
        Write-Verbose -Message "Ending [$($MyInvocation.Mycommand)]"
    }
}
