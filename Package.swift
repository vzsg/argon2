// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "Argon2",
    targets: [
        Target(name: "Argon2", dependencies: ["CArgon2"])
    ]
)
