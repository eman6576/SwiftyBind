// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftyBind",
    products: [
        .library(
            name: "SwiftyBind",
            targets: ["SwiftyBind"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "SwiftyBind",
            dependencies: []),
        .testTarget(
            name: "SwiftyBindTests",
            dependencies: ["SwiftyBind"]),
    ]
)
