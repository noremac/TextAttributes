// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "TextStyle",
    platforms: [
        .iOS(.v13),
        .tvOS(.v13),
        .macOS(.v10_15),
        .watchOS(.v6),
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "TextStyle",
            targets: ["TextStyle"]
        ),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "TextStyle",
            dependencies: []
        ),
        .testTarget(
            name: "TextStyleTests",
            dependencies: ["TextStyle"]
        ),
    ]
)
