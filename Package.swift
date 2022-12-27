// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AdventOfCode",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .executable(name: "AdventOfCode", targets: ["AdventOfCode"]),
        .library(name: "Utilities", targets: ["Utilities"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-algorithms", from: "1.0.0"),
    ],
    targets: [
        .executableTarget(
            name: "AdventOfCode",
            dependencies: [
                "AdventOfCode2022",
            ]
        ),
        .target(
            name: "Utilities",
            dependencies: [
                .product(name: "Algorithms", package: "swift-algorithms"),
            ]
        ),
        .target(
            name: "AdventOfCode2022",
            dependencies: ["Utilities"]
        ),
    ]
)
