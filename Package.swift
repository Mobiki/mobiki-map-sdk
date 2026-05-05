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
            url: "https://github.com/Mobiki/mobiki-map-sdk/releases/download/v1.0.4/MobikiSDK.xcframework.zip",
            checksum: "b189bb58f57d9252c2f3afe6a33ed415951a20652441756a4b401a8acff82c2b"
        )
    ]
)
