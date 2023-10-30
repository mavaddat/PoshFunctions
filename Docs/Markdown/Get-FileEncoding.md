---
external help file: PoshFunctions-help.xml
Module Name: poshfunctions
online version: http://wonkysoftware.appspot.com
schema: 2.0.0
---

# Get-FileEncoding

## SYNOPSIS
To get the file encoding of a file

## SYNTAX

```
Get-FileEncoding [-Path] <String> [<CommonParameters>]
```

## DESCRIPTION
To get the file encoding of a file

## EXAMPLES

### EXAMPLE 1
```
Get-FileEncoding -Path .\UTF16-BigEndian.txt
```

Unicode UTF-16 Big-Endian

### EXAMPLE 2
```
Get-FileEncoding -Path .\UTF16-LittleEndian.txt
```

Unicode UTF-16 Little-Endian

## PARAMETERS

### -Path
The file that you want to check its encoding.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
# source: https://gist.github.com/jpoehls/2406504

## RELATED LINKS
