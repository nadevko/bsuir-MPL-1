// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Lab02",
  targets: [
    .executableTarget(name: "01", path: "Sources/01"),
    .executableTarget(name: "02", path: "Sources/02"),
  ]
)
