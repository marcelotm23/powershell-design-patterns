# Adapter
## Overview          [![wikipedia_adapter](https://img.shields.io/badge/-Wikipedia-black?logo=Wikipedia)](https://en.wikipedia.org/wiki/Adapter_pattern)
The adapter design pattern is one of the twenty-three well-known GoF design patterns that describe how to solve recurring design problems to design flexible and reusable object-oriented software, that is, objects that are easier to implement, change, test, and reuse.

The adapter design pattern solves problems like:

* How can a class be reused that does not have an interface that a client requires?
* How can classes that have incompatible interfaces work together?
* How can an alternative interface be provided for a class?

![diagram](https://upload.wikimedia.org/wikipedia/commons/3/35/ClassAdapter.png)

## Example [![powershell code](https://img.shields.io/badge/download-PowerShell%20code-blue)](./Adapter.ps1)
```powershell
# Target classes
class Radio {
    [string] Hear() {
        return "$this connect to a radio channel"
    }
}

class TV {
    [string] View() {
        return "$this is view a TV show about music"
    }
}

class Phone {
    [string] Play() {
        return "$this play music from internet"
    }
}
```

Each of the classes has a method that returns a string. Radio has Hear, TV has View and Phone has Play. If we want to print these strings, we’d have to know which one we were working with and then call the correct name to get the result. It’d be much easier if we could call the same method on each. It would simplfy our code, wouldn’t need a switch or if statements, the script would be short and there would less of a chance of introducing errors.

```powershell
#Adapter class
class Adapter {
    [object] static Adapt($obj, $alias, $referenced) {

       # Should use Invoke-Expression, because first part of pipeline don't works alone
        return ("`$obj | Add-Member -PassThru -Force -MemberType ScriptMethod -Name $alias -Value {`$this.$referenced}") | Invoke-Expression
    }
}
```

Let’s just pick Hear as the name we want to call on each to get the string back and the three concerned classes have methods with similar objective: _hear something of music_. 

```powershell
# Main code

$targetObjects = @()
$targetObjects+= [Radio]::new()

$o=[TV]::new()
$targetObjects+=[Adapter]::Adapt($o, "Hear", "View()")

$o=[Phone]::new()
$targetObjects+=[Adapter]::Adapt($o, "Hear", "Play()")

# Call same objective method
$targetObjects.Hear()
```
First we’ll create an array _$targetObjects_ to hold Radio, TV and Phone. That way we can leverage PowerShell’s capability to unroll the array and call a mehod on each like this _$targetObjects.Execute()_.

