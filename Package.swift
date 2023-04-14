// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Spider",
    platforms: [.iOS(.v13)],
    products: [

        .library(
            name: "Spider", 
            targets: ["Spider"]
        ),

        .library(
            name: "SpiderUI", 
            targets: ["SpiderUI"]
        ),

        .library(
            name: "SpiderPromise",
            targets: ["SpiderPromise"]
        ),

        .library(
            name: "SpiderPromiseUI", 
            targets: ["SpiderPromiseUI"]
        )

    ],
    dependencies: [

        .package(
            name: "Espresso",
            url: "https://github.com/mitchtreece/Espresso",
            .branch("release/3.1.0")
            // .upToNextMajor(from: .init(3, 1, 0))
        ),

        .package(
            name: "Reachability",
            url: "https://github.com/ashleymills/Reachability.swift",
            .upToNextMajor(from: .init(5, 0, 0))
        ),

        .package(
            name: "Kingfisher",
            url: "https://github.com/onevcat/Kingfisher",
            .upToNextMajor(from: .init(7, 0, 0))
        ),

        .package(
            name: "PromiseKit",
            url: "https://github.com/mxcl/PromiseKit",
            .upToNextMajor(from: .init(6, 0, 0))
        )

    ],
    targets: [

        .target(
            name: "Spider",
            dependencies: [

                .product(
                    name: "EspressoLibSupport_Spider",
                    package: "Espresso"
                ),
                
                .product(
                    name: "Reachability",
                    package: "Reachability"
                )

            ],
            path: "Sources/Core"
        ),

        .target(
            name: "SpiderUI",
            dependencies: [

                .target(name: "Spider"), // Core
                
                .product(
                    name: "Kingfisher", 
                    package: "Kingfisher"
                )

            ],
            path: "Sources/UI"
        ),

        .target(
            name: "SpiderPromise",
            dependencies: [

                .target(name: "Spider"), // Core

                .product(
                    name: "PromiseKit", 
                    package: "PromiseKit"
                )

            ],
            path: "Sources/Promise"
        ),

        .target(
            name: "SpiderPromiseUI",
            dependencies: [

                .target(name: "SpiderUI"),
                .target(name: "SpiderPromise")

            ],
            path: "Sources/PromiseUI"
        )

    ],
    swiftLanguageVersions: [.v5]
)
