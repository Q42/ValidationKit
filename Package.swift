// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "ValidationKit",
    platforms: [
      .macOS(.v14),
      .iOS(.v17)
    ],
    products: [
        .library(name: "ValidationKit", targets: ["ValidationKit"]),
        .library(name: "ValidationKitUI", targets: ["ValidationKitUI"]),
    ],
    targets: [
        .target(name: "ValidationKit"),
        .target(name: "ValidationKitUI", dependencies: ["ValidationKit"]),
        .testTarget(name: "ValidationKitTests", dependencies: ["ValidationKit"]),
        .testTarget(name: "ValidationKitUITests", dependencies: ["ValidationKitUI"]),
    ]
)
