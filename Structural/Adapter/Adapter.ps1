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

class Adapter {
    [object] static Adapt($obj, $alias, $referenced) {

       # Should use Invoke-Expression, because first part of pipeline don't works alone
        return ("`$obj | Add-Member -PassThru -Force -MemberType ScriptMethod -Name $alias -Value {`$this.$referenced}") | Invoke-Expression
    }
}
# Main code

$targetObjects = @()
$targetObjects+= [Radio]::new()

$o=[TV]::new()
$targetObjects+=[Adapter]::Adapt($o, "Hear", "View()")

$o=[Phone]::new()
$targetObjects+=[Adapter]::Adapt($o, "Hear", "Play()")

$targetObjects.Hear()