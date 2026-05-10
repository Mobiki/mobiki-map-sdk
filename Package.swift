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
            url: "https://github.com/Mobiki/mobiki-map-sdk/releases/download/v1.0.9/MobikiSDK.xcframework.zip",
            checksum: "5822fd8844aa11a0155311b7857bb7cdb414893adcd166fad73ddcee04d20f4d"
        )
    ]
)
