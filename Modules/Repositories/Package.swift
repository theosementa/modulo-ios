// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Repositories",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "Repositories", targets: ["Repositories"])
    ],
    dependencies: [
        .package(name: "Models", path: "../Models"),
        .package(name: "Persistence", path: "../Persistence")
    ],
    targets: [
        .target(
            name: "Repositories",
            dependencies: [
                .product(name: "Models", package: "Models"),
                .product(name: "Persistence", package: "Persistence")
            ]
        )
    ]
)
