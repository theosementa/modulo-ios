// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Stores",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "Stores",
            targets: ["Stores"]
        )
    ],
    dependencies: [
        .package(name: "Repositories", path: "../Repositories")
    ],
    targets: [
        .target(
            name: "Stores",
            dependencies: [
                .product(name: "Repositories", package: "Repositories")
            ]
        )
    ]
)
