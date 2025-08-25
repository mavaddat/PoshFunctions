---
external help file: PoshFunctions-help.xml
Module Name: PoshFunctions
online version: https://www.Google.com
schema: 2.0.0
---

# Invoke-CountdownTimer

## SYNOPSIS
Invokes a countdown timer

## SYNTAX

### Seconds (Default)
```
Invoke-CountdownTimer [[-Seconds] <Int32>] [-Description <String>] [-Notify] [<CommonParameters>]
```

### Minutes
```
Invoke-CountdownTimer [-Minutes <Int32>] [-Description <String>] [-Notify] [<CommonParameters>]
```

## DESCRIPTION
Invokes a countdown timer where you specify the number of seconds, or the number of minutes.
Can specify descriptive text
that appears in the progress bar.
Optionally can also beep when completed.
Function aliased to 'CountdownTimer'

## EXAMPLES

### EXAMPLE 1
```
Invoke-CountdownTimer  -Description 'My descriptive text' -Verbose -Minutes 1
```

VERBOSE: Starting \[Invoke-CountdownTimer\]
VERBOSE: ParameterSetName \[Minutes\]
VERBOSE: Seconds \[60\], Minutes \[1\], Description \[My descriptive text\], Notify \[False\]
VERBOSE: Ending \[Invoke-CountdownTimer\]

Would display a progress bar counting down from 60 seconds

### EXAMPLE 2
```
Invoke-CountdownTimer -Verbose
```

VERBOSE: Starting \[Invoke-CountdownTimer\]
VERBOSE: ParameterSetName \[Seconds\]
VERBOSE: Seconds \[10\], Minutes \[0\], Description \[Countdown timer\], Notify \[False\]
VERBOSE: Ending \[Invoke-CountdownTimer\]

Would display a progress bar counting down from 10 seconds

### EXAMPLE 3
```
Invoke-CountdownTimer -Notify
```

Would display a progress bar counting down from 10 seconds and beep when finished

## PARAMETERS

### -Seconds
An integer representing the number of seconds specified.
Valid range 10-1800 seconds.
Defaults to 30 if not specified

```yaml
Type: Int32
Parameter Sets: Seconds
Aliases:

Required: False
Position: 1
Default value: 30
Accept pipeline input: False
Accept wildcard characters: False
```

### -Minutes
An integer representing the number of minutes specified.
Valid range 1-30 minutes

```yaml
Type: Int32
Parameter Sets: Minutes
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Description
A descriptive caption that appears in the progress bar.
Defaults to 'Countdown timer'

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Countdown timer
Accept pipeline input: False
Accept wildcard characters: False
```

### -Notify
Switch indicating that a call to Invoke-Beep should be made when the countdown timer is completed

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
This is not a precise countdown timer.
The actual time elapsed may be several seconds more than what is specified

Measure-Command { Invoke-CountdownTimer }

Took 10.29 seconds

Measure-Command { Invoke-CountdownTimer -Minutes 1 }

Took 60.74 seconds

## RELATED LINKS
