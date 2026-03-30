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
        .package(url: "https://github.com/theosementa/NavigationKit", branch: "3.0.3")
    ],
    targets: [
        .target(
            name: "Navigation",
            dependencies: [
                .product(name: "NavigationKit", package: "NavigationKit")
            ]
        )
    ]
)
