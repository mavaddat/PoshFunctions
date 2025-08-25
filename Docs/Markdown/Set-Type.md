---
external help file: PoshFunctions-help.xml
Module Name: PoshFunctions
online version:
schema: 2.0.0
---

# Set-Type

## SYNOPSIS
Sets the data type of a property given the property name and the data type.

## SYNTAX

```
Set-Type [[-InputObject] <PSObject[]>] [[-TypeHash] <Hashtable>] [<CommonParameters>]
```

## DESCRIPTION
Sets the data type of a property given the property name and the data type.
This is needed as cmdlets such as Import-CSV pulls everything in as a string
datatype so you can't sort numerically or date wise.

## EXAMPLES

### EXAMPLE 1
```
$csv = Import-CSV -Path .\test.csv | Set-Type -TypeHash @{ 'LastWriteTime' = 'DateTime'}
```

## PARAMETERS

### -InputObject
{{ Fill InputObject Description }}

```yaml
Type: PSObject[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -TypeHash
A hashtable of property names and their associated datatype

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
# inspired by https://mjolinor.wordpress.com/2011/05/01/typecasting-imported-csv-data/

Changes
* reworked with begin, process, end blocks
* reworked logic to work properly with pwsh and powershell

## RELATED LINKS

[about_Properties]()

