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
            url: "https://github.com/Mobiki/mobiki-map-sdk/releases/download/v1.0.1/MobikiSDK.xcframework.zip",
            checksum: "11cd2181f8bd72673502b8e4a2f3aef43e3a2103147104f0c0b928d91ef4b16c"
        )
    ]
)
