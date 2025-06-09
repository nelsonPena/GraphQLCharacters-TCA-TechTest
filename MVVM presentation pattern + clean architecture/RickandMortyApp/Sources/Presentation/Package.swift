// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Presentation",
    platforms: [.iOS(.v17)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Characters",
            targets: ["Characters"]),
        .library(
            name: "Splash",
            targets: ["Splash"]),
    ],
    dependencies: [
        .package(name: "Domain", path: "../Domain"),
        .package(url: "https://github.com/SDWebImage/SDWebImageSwiftUI.git", from: "2.2.3"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Characters",
            dependencies: [
                .product(name: "SDWebImageSwiftUI", package: "SDWebImageSwiftUI"),
                .product(name: "Entities", package: "Domain")
            ]
        ),
        .target(
            name: "Splash",
            dependencies: []
        ),
        .testTarget(
            name: "PresentationTests",
            dependencies: [
                .product(name: "UseCaseProtocol", package: "Domain"),
            ]
        ),
    ]
)
