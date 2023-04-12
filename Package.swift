// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Spider",
    platforms: [.iOS(.v13)],
    swiftLanguageVersions: [.v5],
    dependencies: [],
    products: [

        .library(
            name: "SpiderCore", 
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
            name: "SpiderUIKit_Promise", 
            targets: ["UIKit_Promise"]
        )

    ],
    targets: [

        .target(
            name: "Core",
            path: "Sources/Core",
            dependencies: []
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

            ]
        ),

        .target(
            name: "UIKit_Promise",
            path: "Sources/UI/UIKit-Promise",
            dependencies: [

                .target(name: "UIKit"),
                .target(name: "Promise")

            ]
        )

    ]
)
