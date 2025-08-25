---
external help file: PoshFunctions-help.xml
Module Name: PoshFunctions
online version: https://github.com/iRon7/Join-Object
schema: 2.0.0
---

# mklink

## SYNOPSIS
mklink calls out to the Command Prompt (cmd.exe) and creates a link

## SYNTAX

```
mklink
```

## DESCRIPTION
mklink calls out to the Command Prompt (cmd.exe) and creates a link

mklink /?
Creates a symbolic link.

MKLINK \[\[/D\] | \[/H\] | \[/J\]\] Link Target

        /D      Creates a directory symbolic link. 
Default is a file
                symbolic link.
        /H      Creates a hard link instead of a symbolic link.
        /J      Creates a Directory Junction.
        Link    Specifies the new symbolic link name.
        Target  Specifies the path (relative or absolute) that the new link
                refers to.

## EXAMPLES

### EXAMPLE 1
```
mklink LINK REALFILE
```

would return
symbolic link created for link \<\<===\>\> realfile

## PARAMETERS

## INPUTS

## OUTPUTS

## NOTES
Passes all command line arguments to cmd.exe embedded command mklink

## RELATED LINKS
