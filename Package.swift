// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "ValidationKit",
  defaultLocalization: "en",
  platforms: [.macOS(.v10_15), .iOS(.v15), .tvOS(.v15), .macCatalyst(.v15), .watchOS(.v6)],
  products: [
    .library(name: "ValidationKit", targets: ["ValidationKit"]),
  ],
  targets: [
    .target(name: "ValidationKit", dependencies: [], resources: [.process("Resources")]),
    .testTarget(name: "ValidationKitTests", dependencies: ["ValidationKit"]),
  ]
)
