---
external help file: PoshFunctions-help.xml
Module Name: poshfunctions
online version:
schema: 2.0.0
---

# Test-Password

## SYNOPSIS
To validate credentials and return a boolean

## SYNTAX

### Credential (Default)
```
Test-Password -Domain <String> -Credential <PSCredential> [<CommonParameters>]
```

### SecureString
```
Test-Password -Domain <String> -UserName <String> -Password <SecureString> [<CommonParameters>]
```

## DESCRIPTION
To validate credentials and return a boolean.
Can specify either a credential or username and securestring.
Default ParameterSetName 'Credential'

## EXAMPLES

### EXAMPLE 1
```
Test-Password -Domain contosco.com -Credential $GoodCredential
```

$true

### EXAMPLE 2
```
Test-Password -Domain contosco.com -Credential $BadCredential
```

$false

### EXAMPLE 3
```
Test-Password -UserName $username -Password $goodpassword -Domain contosco
```

True

### EXAMPLE 4
```
Test-Password -UserName $username -Password $badpassword -Domain contosco
```

False

### EXAMPLE 5
```
Test-Password -Credential $LocalCred -Domain '.'
```

True

### EXAMPLE 6
```
Test-Password -UserName $localuser -Password $localpassword -Domain '.'
```

True

## PARAMETERS

### -Domain
Where the credential is being checked against.
Either ('.' or $env:computername) or (domainname with or without .com)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UserName
The username to check.
ParameterSetName 'SecureString'

```yaml
Type: String
Parameter Sets: SecureString
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Password
The password passed as a securestring.
ParameterSetName 'SecureString'

```yaml
Type: SecureString
Parameter Sets: SecureString
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential
Credential ParameterSetName 'Credential'

```yaml
Type: PSCredential
Parameter Sets: Credential
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### bool
## NOTES
# inspired by https://community.idera.com/database-tools/powershell/powertips/b/tips/posts/validating-user-account-passwords-part-2
# extra code to fix .ValidateCredentials error https://stackoverflow.com/questions/46170531/exception-in-validatecredentials-the-server-cannot-handle-directory-requests#comment95679386_46172068

* added code to allow domain to be specified as '.' aka the local machine
* added parameter set names to allow for either a credential to be passed or a combination username / password (as a securestring)

## RELATED LINKS
