# Strategy
## Overview          [![wikipedia_strategy](https://img.shields.io/badge/-Wikipedia-black?logo=Wikipedia)](https://en.wikipedia.org/wiki/Strategy_pattern)
 The strategy pattern (also known as the policy pattern) is a behavioral software design pattern that enables selecting an algorithm at runtime. Instead of implementing a single algorithm directly, code receives run-time instructions as to which in a family of algorithms to use.

![diagram](https://upload.wikimedia.org/wikipedia/commons/3/39/Strategy_Pattern_in_UML.png)

## Example [![powershell code](https://img.shields.io/badge/download-PowerShell%20code-blue)](./Strategy.ps1)

Exist a game that is compatible with two game consoles. We would use strategy pattern to allow change the way of run it depending of target console.
```powershell
# Strategy
class GameConsole {
    [string] $Name
    hidden [DateTime] $StartTime = [DateTime]::Now

    GameConsole($Name) {
        $this.Name = $Name
    }

    [TimeSpan] GetElapsed(){
        return [DateTime]::Now - $this.StartTime
    }
}

```
It has been created a _GameConsole_ abstract class and implemented various subclasses to implement the different Game console strategies. Each console has a different way of process a game.

Powershell Classes don’t have support for .NET Abstract classes so this is really just a base class that implements some common logic.

In this case it's defined two strategies for two different game consoles: PlayStation 4 and Xbox One.

```powershell
# Concrete Strategies
class PlayStation4 : GameConsole {

    Copy () : base('PlayStation4') { }

    Play([Game]$g) {

       # Play game in a PlayStation way
    }
}

class XboxOne : GameConsole {

    Copy () : base('XboxOne') { }

    Play([Game]$g) {

       # Play game in a Xbox One way
    }
}

```

It should be noted that both have declared a method called _Play_ where each would implement their specific algorithm to process a game.

The _Game_ class have an array with the compatible game consoles and one method called play to run the game in the mentioned game consoles.

```powershell
# Context
class Game {
    [string] $Name

    hidden [DateTime] $StartTime = [DateTime]::Now
    hidden [Console[]] $GameConsoles = @()

    Game ($Name) {
        $this.Name = $Name
    }

    [TimeSpan] GetElapsed(){
        return [DateTime]::Now - $this.StartTime
    }

    [Game] AddGameConsole([GameConsole]$GC) {
        $this.GameConsoles += $GC

        return $this
    }

    [Game] Play() {
        $this.GameConsoles | ForEach-Object {
            try {
                $_.Play($this)
            }
            catch {
                Write-Host "ERROR:$($_.Exception.Message)")
                break
            }
        }

        return $this
    }

}
```
Finally, the main code would look like this:

```powershell
# Main code
[Game]::New("Red Dead Redemption 2").
    AddGameConsole([PlayStation4]::New()).
    AddGameConsole([XboxOne]::New()).
    Play()
```