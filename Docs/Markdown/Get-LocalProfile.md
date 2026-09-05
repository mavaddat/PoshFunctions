---
external help file: PoshFunctions-help.xml
Module Name: PoshFunctions
online version:
schema: 2.0.0
---

# Get-LocalProfile

## SYNOPSIS
Gets a list of all the local profiles on the computer

## SYNTAX

```
Get-LocalProfile
```

## DESCRIPTION
Gets a list of all the local profiles on the computer and returns SID, Account, ProfilePath as result

## EXAMPLES

### EXAMPLE 1
```
Get-LocalProfile
```

SID                                           Account                      ProfilePath
---                                           -------                      -----------
S-1-5-18                                      NT AUTHORITY\SYSTEM          C:\WINDOWS\system32\config\systemprofile
S-1-5-19                                      NT AUTHORITY\LOCAL SERVICE   C:\WINDOWS\ServiceProfiles\LocalService
S-1-5-20                                      NT AUTHORITY\NETWORK SERVICE C:\WINDOWS\ServiceProfiles\NetworkService
S-1-5-21-3173356244-827506543-1080815787-1001 LAPTOP\SampleUser            C:\Users\SampleUser

## PARAMETERS

## INPUTS

## OUTPUTS

## NOTES
Requires Resolve-SID also available in this module

## RELATED LINKS
