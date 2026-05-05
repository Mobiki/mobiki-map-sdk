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
            url: "https://github.com/Mobiki/mobiki-map-sdk/releases/download/v1.0.6/MobikiSDK.xcframework.zip",
            checksum: "f5dd9e9af3f49a1fa818d495daa8025d58071eb1b1f29ba9ea1292a5a6290548"
        )
    ]
)
