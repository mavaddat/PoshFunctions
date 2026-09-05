---
external help file: PoshFunctions-help.xml
Module Name: PoshFunctions
online version:
schema: 2.0.0
---

# Set-FileTime

## SYNOPSIS
A function to change the file time properties: LastWriteTime, LastAccessTime, CreationTime

## SYNTAX

```
Set-FileTime -Path <String[]> [-CreationTime <DateTime>] [-LastAccessTime <DateTime>]
 [-LastWriteTime <DateTime>] [<CommonParameters>]
```

## DESCRIPTION
A function to change the file time properties: LastWriteTime, LastAccessTime, CreationTime

## EXAMPLES

### EXAMPLE 1
```
Test-MyTestFunction -Verbose
```

Explanation of the function or its result.
You can include multiple examples with additional .EXAMPLE lines

## PARAMETERS

### -Path
Path to a file

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -CreationTime
Date to set the CreationTime property to

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LastAccessTime
Date to set the LastAccessTime property to

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LastWriteTime
Date to set the LastWriteTime property to

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
