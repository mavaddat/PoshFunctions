---
external help file: PoshFunctions-help.xml
Module Name: PoshFunctions
online version:
schema: 2.0.0
---

# Get-QuserSession

## SYNOPSIS
Parses the output of quser.exe into structured objects.

## SYNTAX

```
Get-QuserSession [[-ComputerName] <String>] [<CommonParameters>]
```

## DESCRIPTION
Runs quser.exe (optionally against a remote server via -ComputerName) and parses
the fixed-width console output into properly typed properties instead of raw text.

## EXAMPLES

### EXAMPLE 1
```
Get-QuserSession
```

Lists logged on sessions on the local computer.

### EXAMPLE 2
```
Get-QuserSession -ComputerName SQL01
```

Lists logged on sessions on SQL01.

### EXAMPLE 3
```
'SQL01','SQL02' | Get-QuserSession
```

Lists logged on sessions on each computer name piped in.

## PARAMETERS

### -ComputerName
The remote computer to query with 'quser.exe /server:\<ComputerName\>'.
If omitted,
quser.exe is run against the local computer.

```yaml
Type: String
Parameter Sets: (All)
Aliases: CN, Server

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### PoshFunctions.QuserSession
## NOTES

## RELATED LINKS
