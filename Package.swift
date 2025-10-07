// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DropdownTextField",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "DropdownTextField",  // <- THIS must match the target name you import
            targets: ["DropdownTextField"]
        )
    ],
    targets: [
        .target(
            name: "DropdownTextField",
            dependencies: [],
            resources: [
                .process("Resources")
            ]
        ),
        .testTarget(
            name: "DropdownTextFieldTests",
            dependencies: ["DropdownTextField"]
        ),
    ]
)
