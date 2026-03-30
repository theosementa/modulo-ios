// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Features",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "Contribution", targets: ["Contribution"]),
        .library(name: "FinancialGoal", targets: ["FinancialGoal"]),
        .library(name: "Settings", targets: ["Settings"])
    ],
    dependencies: [
        .package(name: "Core", path: "../Core"),
        .package(name: "DesignSystem", path: "../DesignSystem"),
        .package(name: "Navigation", path: "../Navigation"),
        .package(name: "Providers", path: "../Providers"),
        
        .package(url: "https://github.com/izyumkin/MCEmojiPicker", branch: "1.2.3")
    ],
    targets: [
        .target(
            name: "Contribution",
            dependencies: [
                .product(name: "DesignSystem", package: "DesignSystem"),
                .product(name: "Navigation", package: "Navigation"),
                .product(name: "Providers", package: "Providers")
            ]
        ),
        .target(
            name: "FinancialGoal",
            dependencies: [
                .product(name: "DesignSystem", package: "DesignSystem"),
                .product(name: "Navigation", package: "Navigation"),
                .product(name: "Providers", package: "Providers"),
                
                .product(name: "MCEmojiPicker", package: "MCEmojiPicker")
            ]
        ),
        .target(
            name: "Settings",
            dependencies: [
                .product(name: "Core", package: "Core"),
                .product(name: "DesignSystem", package: "DesignSystem"),
                .product(name: "Navigation", package: "Navigation")
            ]
        )
    ]
)
