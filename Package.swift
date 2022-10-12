// swift-tools-version:5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "ValidationKit",
  defaultLocalization: "en",
  products: [
    .library(
      name: "ValidationKit",
      targets: ["ValidationKit"]
    ),
  ],
  dependencies: [
  ],
  targets: [
    .target(
      name: "ValidationKit",
      dependencies: [],
      resources: [.process("Resources")]
    ),
    .testTarget(
      name: "ValidationKitTests",
      dependencies: ["ValidationKit"]
    ),
  ]
)
