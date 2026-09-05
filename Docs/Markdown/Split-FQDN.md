---
external help file: PoshFunctions-help.xml
Module Name: PoshFunctions
online version: https://gist.github.com/Nora-Ballard/11240204
schema: 2.0.0
---

# Split-FQDN

## SYNOPSIS
To split a FQDN string line by into its constituent parts which are separated by a '.'

## SYNTAX

### Parent (Default)
```
Split-FQDN [-FQDN] <String[]> [-Parent] [<CommonParameters>]
```

### Token
```
Split-FQDN [-FQDN] <String[]> [-Token] [<CommonParameters>]
```

### Leaf
```
Split-FQDN [-FQDN] <String[]> [-Leaf] [<CommonParameters>]
```

## DESCRIPTION
To split a FQDN string line by into its constituent parts which are separated by a '.'

## EXAMPLES

### EXAMPLE 1
```
Split-FQDN -FQDN 'server1.contosco.com'
```

server1.contosco.com

### EXAMPLE 2
```
Split-FQDN -FQDN 'server1.contosco.com' -Leaf
```

server1

### EXAMPLE 3
```
'server1.contosco.com' | Split-FQDN
```

contosco.com

### EXAMPLE 4
```
'server1.contosco.com' | Split-FQDN -Leaf
```

server1

## PARAMETERS

### -FQDN
The FQDN string you want to parse.
Can be single string or array of strings.
Values can be passed
via the pipeline as straight text or via property name.
Aliased to 'hostname'

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: HostName

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Parent
Switch to display the parent of the distinguished name.
Default parameter

```yaml
Type: SwitchParameter
Parameter Sets: Parent
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Leaf
Switch to display the leaf of the distinguished name

```yaml
Type: SwitchParameter
Parameter Sets: Leaf
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Token
Switch to return an array of all the parts

```yaml
Type: SwitchParameter
Parameter Sets: Token
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

### string[]
## NOTES

## RELATED LINKS
