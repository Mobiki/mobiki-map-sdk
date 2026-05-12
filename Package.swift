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
            url: "https://github.com/Mobiki/mobiki-map-sdk/releases/download/v1.0.12/MobikiSDK.xcframework.zip",
            checksum: "006949a5de36d1c91e481c7871de3852a9ffa24ef575042532052b84fcfc2c0e"
        )
    ]
)
