---
external help file: PoshFunctions-help.xml
Module Name: PoshFunctions
online version: https://en.wikipedia.org/wiki/Security_Identifier
schema: 2.0.0
---

# Resolve-Sid

## SYNOPSIS
Resolving a SID to a user account, either local or domain

## SYNTAX

```
Resolve-Sid [[-SID] <String>] [-IncludeInput] [<CommonParameters>]
```

## DESCRIPTION
Resolving a SID to a user account, either local or domain

## EXAMPLES

### EXAMPLE 1
```
Resolve-Sid -SID 'S-1-5-18'
```

NT AUTHORITY\SYSTEM

### EXAMPLE 2
```
Resolve-Sid -SID 'S-1-5-20' -IncludeInput
```

SID      Account
---      -------
S-1-5-20 NT AUTHORITY\NETWORK SERVICE

## PARAMETERS

### -SID
A string representing the security identifier in a Windows environment

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeInput
Switch to include the input in the output

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Only works in a Windows environment

## RELATED LINKS

[https://en.wikipedia.org/wiki/Security_Identifier](https://en.wikipedia.org/wiki/Security_Identifier)

