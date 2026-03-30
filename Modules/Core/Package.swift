// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Core",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "Core",
            targets: ["Core"]
        )
    ],
    dependencies: [
        .package(name: "Models", path: "../Models"),
        .package(name: "Navigation", path: "../Navigation")
    ],
    targets: [
        .target(
            name: "Core",
            dependencies: [
                .product(name: "Models", package: "Models"),
                .product(name: "Navigation", package: "Navigation")
            ]
        )
    ]
)
