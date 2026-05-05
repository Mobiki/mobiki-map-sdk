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
            url: "https://github.com/Mobiki/mobiki-map-sdk/releases/download/v1.0.3/MobikiSDK.xcframework.zip",
            checksum: "6da97421440ad13d69a6de5820421c67d837b8085a1d1516b778793c747f1b19"
        )
    ]
)
