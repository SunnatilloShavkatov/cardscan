// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "shs_cardscan",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(name: "shs-cardscan", targets: ["shs_cardscan"]),
    ],
    dependencies: [
        .package(name: "FlutterFramework", path: "../FlutterFramework"),
    ],
    targets: [
        .target(
            name: "CardScanObjC",
            path: "Sources/CardScanObjC",
            publicHeadersPath: "include"
        ),
        .target(
            name: "shs_cardscan",
            dependencies: [
                "CardScanObjC",
                .product(name: "FlutterFramework", package: "FlutterFramework"),
            ],
            path: "Sources/shs_cardscan",
            resources: [
                .process("Resources"),
            ]
        ),
    ]
)
