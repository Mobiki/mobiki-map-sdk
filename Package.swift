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
            url: "https://github.com/Mobiki/mobiki-map-sdk/releases/download/v1.0.11/MobikiSDK.xcframework.zip",
            checksum: "9915adfb7f3e0b1060f5def0f3edfe46c1f8eb2dedf1469f2ae255226acd40e1"
        )
    ]
)
