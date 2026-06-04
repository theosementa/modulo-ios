// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Navigation",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "Navigation",
            targets: ["Navigation"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/neopixl/PharosNav-ios.git", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "Navigation",
            dependencies: [
                .product(name: "PharosNav", package: "PharosNav-ios")
            ]
        )
    ]
)
