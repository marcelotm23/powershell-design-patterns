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
# Main code
[Game]::New("Red Dead Redemption 2").
    AddGameConsole([PlayStation4]::New()).
    AddGameConsole([XboxOne]::New()).
    Play()