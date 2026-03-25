// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Features",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "FinancialGoal", targets: ["FinancialGoal"])
    ],
    dependencies: [
        .package(name: "DesignSystem", path: "../DesignSystem"),
        .package(name: "Navigation", path: "../Navigation"),
        .package(name: "Providers", path: "../Providers")
    ],
    targets: [
        .target(
            name: "FinancialGoal",
            dependencies: [
                .product(name: "DesignSystem", package: "DesignSystem"),
                .product(name: "Navigation", package: "Navigation"),
                .product(name: "Providers", package: "Providers")
            ]
        )
    ]
)
