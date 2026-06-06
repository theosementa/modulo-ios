// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DataSources",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "DataSources",
            targets: ["DataSources"]
        )
    ],
    dependencies: [
        .package(name: "Repositories", path: "../Repositories"),
        .package(name: "Utilities", path: "../Utilities")
    ],
    targets: [
        .target(
            name: "DataSources",
            dependencies: [
                .product(name: "Repositories", package: "Repositories"),
                .product(name: "Utilities", package: "Utilities")
            ]
        )
    ]
)
