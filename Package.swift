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
            url: "https://github.com/Mobiki/mobiki-map-sdk/releases/download/v1.0.5/MobikiSDK.xcframework.zip",
            checksum: "40c6bedad2162a041bcf0fa679cbeb097d8f5120d50b691f5e56ad98336910c3"
        )
    ]
)
