// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "MuzzCodeChallenge",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "MuzzCodeChallenge",
            targets: ["MuzzCodeChallenge"]),
    ],
    dependencies: [
        .package(url: "https://github.com/nathantannar4/InputBarAccessoryView.git", .upToNextMajor(from: "6.0.0"))
    ],
    targets: [
        .target(
            name: "MuzzCodeChallenge",
            dependencies: ["InputBarAccessoryView"]),
    ]
) 