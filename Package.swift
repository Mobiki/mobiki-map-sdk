// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "MobikiSDK",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "MobikiSDK", targets: ["MobikiSDK"])
    ],
    targets: [
        .binaryTarget(
            name: "MobikiSDK",
            url: "https://github.com/Mobiki/mobiki-map-sdk/releases/download/v1.0.10/MobikiSDK.xcframework.zip",
            checksum: "416c51980e8912ac27de9795a4aa247435147722b01d9e67ecf096576876bebc"
        )
    ]
)
