// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Presenters",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "Presenters",
            targets: ["Presenters"]
        )
    ],
    dependencies: [
        .package(name: "Models", path: "../Models"),
        .package(name: "DataSources", path: "../DataSources"),
        .package(name: "Utilities", path: "../Utilities")
    ],
    targets: [
        .target(
            name: "Presenters",
            dependencies: [
                .product(name: "Models", package: "Models"),
                .product(name: "DataSources", package: "DataSources"),
                .product(name: "Utilities", package: "Utilities")
            ]
        )
    ]
)
