---
external help file: PoshFunctions-help.xml
Module Name: PoshFunctions
online version:
schema: 2.0.0
---

# ConvertTo-UTC

## SYNOPSIS
Converts a datetime from local time to UTC

## SYNTAX

```
ConvertTo-UTC [-Date] <DateTime[]> [-IncludeOriginal] [<CommonParameters>]
```

## DESCRIPTION
Converts a datetime from local time to UTC.
Can optionally include the original datetime entered.

## EXAMPLES

### EXAMPLE 1
```
ConvertTo-UTC -Date '1/25/2018 8:34:31 AM'
```

Assuming that your local time zone is EST, and your region/culture is EN-US this would return the string

Thursday, January 25, 2018 1:34:31 PM

### EXAMPLE 2
```
ConvertTo-UTC '2/1/2018 4:27:59 PM'
```

Assuming that your local time zone is EST, and your region/culture is EN-US this would return the string

Thursday, February 01, 2018 9:27:59 PM

### EXAMPLE 3
```
"3/15/2018 12:00:00 PM" | ConvertTo-UTC
```

Assuming that your local time zone is EST, and your region/culture is EN-US this would return the string

Thursday, March 15, 2018 4:00:00 PM

### EXAMPLE 4
```
"3/15/2018 12:00:00 PM" | ConvertTo-UTC -IncludeOriginal
```

Assuming that your local time zone is EST, and your region/culture is EN-US this would return the string

Original              UTC
--------              ---
3/15/2018 12:00:00 PM 3/15/2018 4:00:00 PM

## PARAMETERS

### -Date
The datetime that you wish to be converted to UTC.
Can be a single datetime or an array.
Can be passed from the pipeline.
This parameter has an alias of 'DateTime'.

```yaml
Type: DateTime[]
Parameter Sets: (All)
Aliases: DateTime

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -IncludeOriginal
A switch which controls if you wish to see the original inputted date in the output.

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

### datetime
## NOTES

## RELATED LINKS
