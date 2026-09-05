---
external help file: PoshFunctions-help.xml
Module Name: PoshFunctions
online version:
schema: 2.0.0
---

# New-LocalAdmin

## SYNOPSIS
Creates a new local administrative account on local computer

## SYNTAX

```
New-LocalAdmin [-LocalAdmin] <String> [-PasswordPlaintext] <String> [-Description] <String>
 [<CommonParameters>]
```

## DESCRIPTION
Creates a new local administrative account on local computer

## EXAMPLES

### EXAMPLE 1
```
Test-MyTestFunction -Verbose
```

Explanation of the function or its result.
You can include multiple examples with additional .EXAMPLE lines

## PARAMETERS

### -LocalAdmin
{{ Fill LocalAdmin Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PasswordPlaintext
{{ Fill PasswordPlaintext Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Description
{{ Fill Description Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: "New local admin created on: $(Get-Date)"
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Information or caveats about the function e.g.
'This function is not supported in Linux'

## RELATED LINKS

[Specify a URI to a help page, this will show when Get-Help -Online is used.]()

