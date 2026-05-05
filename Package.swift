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
            url: "https://github.com/Mobiki/mobiki-map-sdk/releases/download/v1.0.7/MobikiSDK.xcframework.zip",
            checksum: "25f7eaea07cede9058da7a54e1630af557ab89dd5a1df21105071a602824085f"
        )
    ]
)
