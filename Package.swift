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
            url: "https://github.com/Mobiki/mobiki-map-sdk/releases/download/v1.0.0/MobikiSDK.xcframework.zip",
            checksum: "3c4176a966259c948fba85c1f99f1c335dde901a1b32841caba7f242b619fc8c"
        )
    ]
)
