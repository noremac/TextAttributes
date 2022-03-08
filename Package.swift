// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "TextAttributes",
    platforms: [
        .iOS(.v13),
        .tvOS(.v13),
        .macOS(.v10_15),
        .watchOS(.v6),
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "TextAttributes",
            targets: ["TextAttributes"]
        ),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "TextAttributes",
            dependencies: []
        ),
        .testTarget(
            name: "TextAttributesTests",
            dependencies: ["TextAttributes"]
        ),
    ]
)
