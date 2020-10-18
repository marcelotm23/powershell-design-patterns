# Class

class Singleton {
  [string] $value
  static [Singleton] $instance

  static [Singleton] Get() {
    if ($null -eq [Singleton]::instance) {
      [Singleton]::instance = [Singleton]::new()
    }
    return [Singleton]::instance
  }
}

# Main Code

$singleton = [Singleton]::Get()
$singleton.value = "There is only one instance!"

$another_singleton = [Singleton]::Get()
Write-Host $another_singleton.value