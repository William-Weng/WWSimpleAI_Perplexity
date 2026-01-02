// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.


import PackageDescription

let package = Package(
    name: "WWSimpleAI_Perplexity",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(name: "WWSimpleAI_Perplexity", targets: ["WWSimpleAI_Perplexity"]),
    ],
    dependencies: [
        .package(url: "https://github.com/William-Weng/WWSimpleAI_Ollama", from: "1.2.0")
    ],
    targets: [
        .target(name: "WWSimpleAI_Perplexity", dependencies: ["WWSimpleAI_Ollama"], resources: [.copy("Privacy")]),
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
