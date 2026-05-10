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
            url: "https://github.com/Mobiki/mobiki-map-sdk/releases/download/v1.0.8/MobikiSDK.xcframework.zip",
            checksum: "ec2f9242a58d4036f09b625690c2e86cfae399adb8a723805175ba723eb88b62"
        )
    ]
)
