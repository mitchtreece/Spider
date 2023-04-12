// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Spider",
    platforms: [.iOS(.v13)],
    swiftLanguageVersions: [.v5],
    dependencies: [],
    products: [

        .library(
            name: "Spider", 
            targets: ["Core"]
        ),

        .library(
            name: "SpiderPromise", 
            targets: ["Promise"]
        ),

        .library(
            name: "SpiderUIKit", 
            targets: ["UIKit"]
        ),

        .library(
            name: "SpiderUIKitPromise", 
            targets: ["UIKitPromise"]
        )

    ],
    targets: [

        .target(
            name: "Core",
            path: "Sources/Core",
            dependencies: [

                // Espresso/Core ~> 3.0

                .package(
                    name: "ReachabilitySwift",
                    url: "https://github.com/ashleymills/Reachability.swift",
                    .upToNextMajor(from: .init(5, 0, 0))
                )

            ]
        ),

        .target(
            name: "Promise",
            path: "Sources/Promise",
            dependencies: [

                .target(name: "Core"),

                .package(
                    name: "PromiseKit",
                    url: "https://github.com/mxcl/PromiseKit",
                    .upToNextMajor(from: .init(6, 0, 0))
                )

            ]
        ),

        .target(
            name: "UIKit",
            path: "Sources/UI/UIKit",
            dependencies: [

                .target(name: "Core")
                
                .package(
                    name: "Kingfisher",
                    url: "https://github.com/onevcat/Kingfisher",
                    .upToNextMajor(from: .init(7, 0, 0))
                )

            ]
        ),

        .target(
            name: "UIKitPromise",
            path: "Sources/UI/UIKitPromise",
            dependencies: [

                .target(name: "UIKit"),
                .target(name: "Promise")

            ]
        )

    ]
)
