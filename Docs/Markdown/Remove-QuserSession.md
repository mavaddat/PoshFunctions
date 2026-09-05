---
external help file: PoshFunctions-help.xml
Module Name: PoshFunctions
online version:
schema: 2.0.0
---

# Remove-QuserSession

## SYNOPSIS
Resets a user session via rwinsta.exe, resolved through Get-QuserSession.

## SYNTAX

### UserName (Default)
```
Remove-QuserSession [-UserName] <String> [-ComputerName <String>] [-Force] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### SessionName
```
Remove-QuserSession -SessionName <String> [-ComputerName <String>] [-Force] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### Id
```
Remove-QuserSession -Id <Int32> [-ComputerName <String>] [-Force] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Looks up a matching session with Get-QuserSession (by UserName, SessionName, or Id)
and, if found and not the session initiating the call, resets it with rwinsta.exe.
A session flagged as the CurrentUser session is never reset - the function emits a
non-terminating error and moves on rather than tearing down its own session.

## EXAMPLES

### EXAMPLE 1
```
Remove-QuserSession -UserName jdoe
```

Resets jdoe's session on the local computer.

### EXAMPLE 2
```
Remove-QuserSession -SessionName 'rdp-tcp#3' -ComputerName SQL01
```

Resets the session named 'rdp-tcp#3' on SQL01.

### EXAMPLE 3
```
Remove-QuserSession -Id 2 -ComputerName SQL01 -WhatIf
```

Shows what would happen if session Id 2 on SQL01 were reset, without doing it.

### EXAMPLE 4
```
Remove-QuserSession -UserName jdoe -ComputerName SQL01 -Force
```

Resets jdoe's session on SQL01 without prompting for confirmation.

## PARAMETERS

### -UserName
The UserName to match against Get-QuserSession output.
Default parameter set.

```yaml
Type: String
Parameter Sets: UserName
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SessionName
The SessionName to match against Get-QuserSession output.

```yaml
Type: String
Parameter Sets: SessionName
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
The session Id to match against Get-QuserSession output.

```yaml
Type: Int32
Parameter Sets: Id
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -ComputerName
The remote computer to operate against.
Passed to both Get-QuserSession and as
'/server:\<ComputerName\>' to rwinsta.exe.
If omitted, the local computer is used.

```yaml
Type: String
Parameter Sets: (All)
Aliases: CN, Server

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force
Suppresses the ShouldProcess confirmation prompt that ConfirmImpact = 'High' would
otherwise trigger.
-WhatIf still short-circuits the action even with -Force.

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

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

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
