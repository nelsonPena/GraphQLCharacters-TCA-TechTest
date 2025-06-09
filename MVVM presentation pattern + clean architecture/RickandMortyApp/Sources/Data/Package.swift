// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Data",
    platforms: [.iOS(.v17)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "NetworkCore",
            targets: ["NetworkCore"]
        ),
        .library(
            name: "Networking",
            targets: ["Networking"]
        ),
        .library(
            name: "Repositories",
            targets: ["Repositories"]
        ),
        .library(
            name: "DB",
            targets: ["DB"]
        ),
        .library(
            name: "Helpers",
            targets: ["Helpers"]
        )
    ],
    dependencies: [
        .package(name: "Domain", path: "../Domain"),
        .package(url: "https://github.com/Quick/Quick", from: "6.1.0"),
        .package(url: "https://github.com/Quick/Nimble", from: "11.2.1")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "NetworkCore",
            dependencies: [.product(name: "Entities", package: "Domain")]
        ),
        .target(
            name: "Networking",
            dependencies: [
                "NetworkCore",
                "Helpers"
            ]
        ),
        .target(
            name: "Repositories",
            dependencies: [
                "NetworkCore",
                "DB",
                .product(name: "Entities", package: "Domain"),
                .product(name: "RepositoryProtocol", package: "Domain")
            ]
        ),
        .target(
            name: "DB",
            dependencies: [
                .product(name: "Entities", package: "Domain")
            ]
        ),
        .target(
            name: "Helpers",
            dependencies: []
        ),
        .testTarget(
            name: "DataTests",
            dependencies: [
                .product(name: "Quick", package: "Quick"),
                .product(name: "Nimble", package: "Nimble"),
                .product(name: "RepositoryProtocol", package: "Domain"),
                "NetworkCore",
                "Repositories"
            ]
        ),
    ]
)
