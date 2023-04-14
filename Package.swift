// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Spider",
    platforms: [.iOS(.v13)],
    products: [

        .library(
            name: "Core", 
            targets: ["Spider"]
        ),

        .library(
            name: "UI", 
            targets: ["SpiderUI"]
        ),

        .library(
            name: "Promise", 
            targets: ["SpiderPromise"]
        ),

        .library(
            name: "PromiseUI", 
            targets: ["SpiderPromiseUI"]
        )

    ],
    dependencies: [],
    targets: [

        .target(
            name: "Spider",
            dependencies: [

                .package(
                    name: "Espresso/LibSupport/Spider", // TODO: How do I specify a Vendor-SpiderCore target?
                    url: "https://github.com/mitchtreece/Espresso",
                    .upToNextMajor(from: .init(3, 1, 0))
                ),

                .package(
                    name: "ReachabilitySwift",
                    url: "https://github.com/ashleymills/Reachability.swift",
                    .upToNextMajor(from: .init(5, 0, 0))
                )

            ],
            path: "Sources/Core"
        ),

        .target(
            name: "SpiderUI",
            dependencies: [

                .target(name: "Spider"), // Core
                
                .package(
                    name: "Kingfisher",
                    url: "https://github.com/onevcat/Kingfisher",
                    .upToNextMajor(from: .init(7, 0, 0))
                )

            ],
            path: "Sources/UI"
        ),

        .target(
            name: "SpiderPromise",
            dependencies: [

                .target(name: "Spider"), // Core

                .package(
                    name: "PromiseKit",
                    url: "https://github.com/mxcl/PromiseKit",
                    .upToNextMajor(from: .init(6, 0, 0))
                )

            ],
            path: "Sources/Promise"
        ),

        .target(
            name: "SpiderPromiseUI",
            dependencies: [

                .target(name: "SpiderUI"),
                .target(name: "Promise")

            ],
            path: "Sources/PromiseUI"
        )

    ],
    swiftLanguageVersions: [.v5]
)
