// swift-tools-version: 5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CombineNSObject",
    platforms: [.iOS(.v13), .macOS(.v10_15)],
    products: [
        .library(
            name: "CombineNSObject",
            targets: ["CombineNSObject"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "CombineNSObject",
            dependencies: [],
            path: "CombineNSObject"
        ),
    ]
)
