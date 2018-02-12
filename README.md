# SwiftyBind

A Swifty approach to notification based programming

[![Build Status](https://travis-ci.org/eman6576/SwiftyBind.svg?branch=master)](https://travis-ci.org/eman6576/SwiftyBind)
[![codecov](https://codecov.io/gh/eman6576/SwiftyBind/branch/master/graph/badge.svg)](https://codecov.io/gh/eman6576/SwiftyBind)
![Swift 4.0](https://img.shields.io/badge/Swift-4.0-orange.svg?style=flat)
[![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)
[![DUB](https://img.shields.io/dub/l/vibe-d.svg)](https://github.com/eman6576/SwiftyBind/blob/master/LICENSE)
[![platform](https://img.shields.io/badge/platform-macOS%20%7C%20Linux-lightgrey.svg)]()

## Deprecation Notice

This library has been deprecated in favor of [SGSwiftyBind](https://github.com/eman6576/SGSwiftyBind)

## Overview

Sometimes when wanting to know when a value has changed, it can be difficult to write clean, safe code that won't introduce weird behaviors like firing multiple times. SwiftyBind attempts to solve this problem by encapsulating the logic firing notifications. Heres an example:

```
struct Michelle {
    private var spilledTheMilkBinder = SwiftyBind(false)
    var spilledTheMilk {
        return spilledTheMilkBinder.interface
    }

    func spillMilk() {
        spilledTheMilk.value = true
    }
}

protocol FullHouseParent: class {
    var michelle: Michelle { get }
    init(michelle: Michelle)
}

final class BobSaget: FullHouseParent {
    var michelle: Michelle

    init(michelle: Michelle) {
        self.michelle = michelle
        self.michelle.spilledTheMilk.bind {
            if $0 { print("Oh no, why is there milk all over Comet!") }
        }
    }
}

let michelle = Michelle()
let bobSaget = BobSaget(michelle)
michelle.spillMilk()
```

In the example, notice how when `spillMilk` is invoked on the `Michelle` instance, this will notify the registered closure only once.

## Installation

### Swift Package Manager

You can add SwiftyBind to your `Package.swift` file like so:
```
dependencies: [
    .package(url: "https://github.com/eman6576/SwiftyBind.git", from: "1.0.0")
]
```

## License

SwiftyBind is released under the MIT license. [See LICENSE](https://github.com/eman6576/SwiftyBind/blob/master/LICENSE) for details.

