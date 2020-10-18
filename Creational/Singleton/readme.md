# Singleton
## Overview

In software engineering, the singleton pattern is a software design pattern that restricts the instantiation of a class to one "single" instance. This is useful when exactly one object is needed to coordinate actions across the system.

## Example

The *Singleton* class always returns the same instance, as *Get()* checks if there is already an existing instance. To achive this we have to define the *Get()* function and the saved instance within the class as **static**.

```powershell
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
```