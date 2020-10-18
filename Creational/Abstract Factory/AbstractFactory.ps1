# Classes

class AbstractFactory {
  [string] $Name

  AbstractFactory ([string] $Name) {
    $type = $this.GetType()

    if ($type -eq [AbstractFactory]) {
      throw("Class $type cannot be constructed!")
    }
    $this.Name = $Name
  }

  [AbstractProduct] Produce() {
    throw("Must override method!")
  }
}

class FactoryA : AbstractFactory {
  FactoryA ([string] $Name) : base ($Name) {}

  [ProductA] Produce() {
    return [ProductA]::new($this.Name)
  }
}

class FactoryB : AbstractFactory {
  FactoryB ([string] $Name) : base ($Name) {}

  [ProductB] Produce() {
    return [ProductB]::new($this.Name)
  }
}

class AbstractProduct {
  [string] $Factory

  AbstractProduct ([string] $Factory) {
    $type = $this.GetType()

    if ($type -eq [AbstractProduct]) {
      throw("Class $type cannot be constructed!")
    }
    $this.Factory = $Factory
  }

  [string] Info() {
    throw("Must override method!")
  }
}
 
class ProductA : AbstractProduct {
  ProductA ([string] $Factory) : base ($Factory) {}

  [string] Info() {
      return "ProductA produced by factory " + $this.Factory
  }
}

class ProductB : AbstractProduct {
  ProductB ([string] $Factory) : base ($Factory) {}

  [string] Info() {
      return "ProductB produced by factory " + $this.Factory
  }
}

# Main code

$Factory1 = [FactoryA]::new("A")
$Factory2 = [FactoryB]::new("B")

Write-Host $Factory1.Produce().Info()
Write-Host $Factory2.Produce().Info()