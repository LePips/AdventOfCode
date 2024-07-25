// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AdventOfCode",
    platforms: [
        .macOS(.v13),
    ],
    products: [
        .executable(name: "AdventOfCode", targets: ["AdventOfCode"]),
        .library(name: "Utilities", targets: ["Utilities"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-algorithms", from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-collections", from: "1.0.6")
    ],
    targets: [
        .executableTarget(
            name: "AdventOfCode",
            dependencies: [
                "AdventOfCode2015",
                "AdventOfCode2022",
                "AdventOfCode2023",
            ]
        ),
        .target(
            name: "Utilities",
            dependencies: [
                .product(name: "Algorithms", package: "swift-algorithms"),
                .product(name: "OrderedCollections", package: "swift-collections")
            ]
        ),
        .target(
            name: "AdventOfCode2015",
            dependencies: ["Utilities"]
        ),
        .target(
            name: "AdventOfCode2022",
            dependencies: ["Utilities"]
        ),
        .target(
            name: "AdventOfCode2023",
            dependencies: ["Utilities"]
        ),
    ]
)
