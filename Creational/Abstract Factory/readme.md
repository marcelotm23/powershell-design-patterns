# Abstract Factory
## Overview 
[![wikipedia_adapter](https://img.shields.io/badge/-Wikipedia-black?logo=Wikipedia)](https://en.wikipedia.org/wiki/Abstract_factory_pattern)

The Abstract Factory design pattern is one of the twenty-three well-known GoF design patterns that describe how to solve recurring design problems to design flexible and reusable object-oriented software, that is, objects that are easier to implement, change, test, and reuse.

The Abstract Factory design pattern solves problems like:

- How can an application be independent of how its objects are created?
- How can a class be independent of how the objects it requires are created?
- How can families of related or dependent objects be created?

## Example

Classes in Powershell can be made *"abstract"* by throwing an error if they are directly constructed, as `abstract` is not a valid keyword.

```powershell
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
```

A subclass of the `AbstractFactory` defines it's method with any desired product. The product is created with the factorys name, making it easier to follow the example.

```powershell
class ProductA : AbstractProduct {
  ProductA ([string] $Factory) : base ($Factory) {}

  [string] Info() {
      return "ProductA produced by factory " + $this.Factory
  }
}
```

The following example code creates two factory instances, with each producing one product:

```powershell
$Factory1 = [FactoryA]::new("A")
$Factory2 = [FactoryB]::new("B")

Write-Host $Factory1.Produce().Info()
Write-Host $Factory2.Produce().Info()
```

This creates the following output:
```
ProductA produced by factory A
ProductB produced by factory B
```

## Reference

This example was inspired by [@xainey](https://github.com/xainey)'s blog https://xainey.github.io/2016/powershell-classes-and-concepts/ .