﻿---
external help file: PoshFunctions-help.xml
Module Name: poshfunctions
online version: https://github.com/iRon7/Join-Object
schema: 2.0.0
---

# New-DatePicker

## SYNOPSIS
Provides a GUI representation of a calendar where you select a date.
Click OK or press \[Enter\] to return the date selected.
If click Cancel or press \[Esc\] $null is returned.

## SYNTAX

```
New-DatePicker [[-Title] <String>] [-IncludeTime] [-Date <DateTime>] [<CommonParameters>]
```

## DESCRIPTION
Provides a GUI representation of a calendar where you select a date.
Click OK or press \[Enter\] to return the date selected.
If click Cancel or press \[Esc\] $null is returned.

## EXAMPLES

### EXAMPLE 1
```
New-DatePicker -Title 'This is my custom title' -Verbose
```

VERBOSE: Starting \[New-DatePicker\]
VERBOSE: Title \[This is my custom title\]

Tuesday, August 3, 2021 12:00:00 AM
VERBOSE: Ending \[New-DatePicker\]

### EXAMPLE 2
```
New-DatePicker -Verbose
```

VERBOSE: Starting \[New-DatePicker\]
VERBOSE: Title \[Select a date\]

Tuesday, August 3, 2021 12:00:00 AM
VERBOSE: Ending \[New-DatePicker\]

### EXAMPLE 3
```
New-DatePicker -IncludeTime
```

Wednesday, August 4, 2021 4:55:00 PM

## PARAMETERS

### -Title
The title of the form.
Defaults to 'Select a date'

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: Select a date
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeTime
Switch to include time as part of the picker.
Format is 'ddd MM/dd/yyyy HH:mm' where MM represents the 2 digit month (01-12), HH represents the hour using a 24 hour clock (00-23) and mm represents the 2 digit minute (00-59).
Seconds are truncated to 00.

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

### -Date
Default datetime value for the dialog box

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

### datetime
## NOTES
If -IncludeTime is not specified the time is truncated to midnight (the zero hour) of the day selected.

## RELATED LINKS
