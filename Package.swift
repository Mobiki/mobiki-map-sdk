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
            url: "https://github.com/Mobiki/mobiki-map-sdk/releases/download/v1.0.2/MobikiSDK.xcframework.zip",
            checksum: "c3831b23256236221a566035ccd2cef5259051d8ef9624fc5b1cd07976ed4fd6"
        )
    ]
)
