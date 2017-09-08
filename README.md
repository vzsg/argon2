This repo holds a basic Swift wrapper around [the Argon2 C reference implementation](https://github.com/P-H-C/phc-winner-argon2).

## Warning

The code has proof-of-concept quality, and comes with no warranty of any kind.

## Installation

1. Add the following dependency to your Package.swift:
    ```swift
    .Package(url: "https://github.com/vzsg/argon2.git", majorVersion: 0, minor: 2)
    ```
1. Call `swift package update` and `swift package generate-xcodeproj`.

## Usage

Check the Tests folder.
