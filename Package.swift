// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AdaptiveTabView",
    platforms: [
        .macOS(.v14),
        .iOS(.v17),
        .tvOS(.v17),
    ],
    products: [
        .library(
            name: "AdaptiveTabView",
            targets: ["AdaptiveTabView"]),
    ],
    dependencies: [
        .package(url: "https://github.com/andtie/SequenceBuilder.git", from: "0.0.7")
    ],
    targets: [
        .target(
            name: "AdaptiveTabView",
            dependencies: ["SequenceBuilder"],
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency")
            ])
    ]
)
