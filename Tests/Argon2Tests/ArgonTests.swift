import XCTest
@testable import Argon2

class ArgonTests: XCTestCase {
    static var allTests = [
        ("testArgon2i", testArgon2i),
        ("testArgon2d", testArgon2d),
        ("testArgon2id", testArgon2id),
    ]

    func testArgon2i() {
        testVariant(Argon2.i)
    }

    func testArgon2d() {
        testVariant(Argon2.d)
    }

    func testArgon2id() {
        testVariant(Argon2.id)
    }

    private func testVariant(_ variant: Argon2) {
        let password = [UInt8]("password".utf8)
        let salt = [UInt8]("somesalt".utf8)
        let otherPassword = [UInt8]("drowssap".utf8)

        guard let result = variant.hash(password, salt: salt, timeCost: 2, memoryCost: 16, parallelism: 1) else {
            XCTFail("Failed to hash input")
            return
        }

        XCTAssertTrue(variant.verify(result, against: password))
        XCTAssertFalse(variant.verify(result, against: otherPassword))
    }
}
