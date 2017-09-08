// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "Argon2",
    targets: [
        Target(name: "Argon2", dependencies: ["CArgon2"])
    ]
)
