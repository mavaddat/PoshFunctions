---
external help file: PoshFunctions-help.xml
Module Name: poshfunctions
online version: https://social.msdn.microsoft.com/Forums/vstudio/en-US/0221d962-26e6-4a7e-be7a-72cd669a0dfc/why-systemmathround0251-2?forum=vbgeneral

Talks about Visual Basic but the same info applies to Powershell.
schema: 2.0.0
---

# Get-Round

## SYNOPSIS
Correctly rounds a number.
Optionally can specify the number of digits to round to.

## SYNTAX

```
Get-Round [-Number] <Double[]> [[-Digit] <Int32>] [-IncludeOriginal] [<CommonParameters>]
```

## DESCRIPTION
Correctly rounds a number.
Optionally can specify the number of digits to round to.
Default behavior for \[math\]::Round is to round \[System.MidpointRounding\]::ToEven so 2.5 would round to 2 as opposed to expected behavior of rounding to 3.

Without this \[math\]::Round(0.25, 1) will round to 0.2 as opposed to what it should of 0.3.

## EXAMPLES

### EXAMPLE 1
```
Get-Round 2.5
```

Returns a properly rounded value of 3.

### EXAMPLE 2
```
Get-Round 2.45 -Digit 1
```

Returns a properly rounded value of 2.5.

### EXAMPLE 3
```
Get-Round -Number 2.45 -Digit 1 -IncludeOriginal
```

# Would return
Original Digits Rounded
-------- ------ -------
    2.45      1     2.5

### EXAMPLE 4
```
2.45, 3.22, 7.26 | Get-Round -Digit 1 -IncludeOriginal
```

# Would return
Original Digits Rounded
-------- ------ -------
    2.45      1     2.5
    3.22      1     3.2
    7.26      1     7.3

## PARAMETERS

### -Number
The number to round.
Can be a single number, or an array of numbers.
Positional parameter.
Accepts pipeline input.

```yaml
Type: Double[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Digit
The number of digits after the decimal point.
Defaults to 0.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeOriginal
A switch to determine if you want the input parameters to be included in the output

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

### [double]
## NOTES
# Inspired by: https://stackoverflow.com/questions/41700200/how-to-correctly-round-numbers-in-powershell

## RELATED LINKS

[https://social.msdn.microsoft.com/Forums/vstudio/en-US/0221d962-26e6-4a7e-be7a-72cd669a0dfc/why-systemmathround0251-2?forum=vbgeneral

Talks about Visual Basic but the same info applies to Powershell.](https://social.msdn.microsoft.com/Forums/vstudio/en-US/0221d962-26e6-4a7e-be7a-72cd669a0dfc/why-systemmathround0251-2?forum=vbgeneral

Talks about Visual Basic but the same info applies to Powershell.)

