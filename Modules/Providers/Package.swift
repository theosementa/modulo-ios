// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Providers",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "Providers",
            targets: ["Providers"]
        )
    ],
    dependencies: [
        .package(name: "Models", path: "../Models"),
        .package(name: "Stores", path: "../Stores")
    ],
    targets: [
        .target(
            name: "Providers",
            dependencies: [
                .product(name: "Models", package: "Models"),
                .product(name: "Stores", package: "Stores")
            ]
        )
    ]
)
