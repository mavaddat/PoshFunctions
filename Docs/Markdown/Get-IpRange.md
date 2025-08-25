---
external help file: PoshFunctions-help.xml
Module Name: PoshFunctions
online version:
schema: 2.0.0
---

# Get-IpRange

## SYNOPSIS
Given a subnet in CIDR format, get all of the valid IP addresses in that range.

## SYNTAX

```
Get-IpRange [-Subnets] <String[]> [<CommonParameters>]
```

## DESCRIPTION
Given a subnet in CIDR format, get all of the valid IP addresses in that range.

## EXAMPLES

### EXAMPLE 1
```
Get-IpRange -Subnets '192.168.1.24/30'
```

192.168.1.25
192.168.1.26

### EXAMPLE 2
```
(Get-IpRange -Subnets '10.100.10.0/24').count
```

254

### EXAMPLE 3
```
'192.168.1.128/30' | Get-IpRange
```

192.168.1.129
192.168.1.130

## PARAMETERS

### -Subnets
The subnet written in CIDR format 'a.b.c.d/#' and an example would be '192.168.1.24/27'.
Can be a single value, an
array of values, or values can be taken from the pipeline.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Inspired by https://gallery.technet.microsoft.com/PowerShell-Subnet-db45ec74

* Added comment help

## RELATED LINKS
