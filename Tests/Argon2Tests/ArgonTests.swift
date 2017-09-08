import XCTest
@testable import Argon2

class ArgonTests: XCTestCase {
    static var allTests = [
        ("testArgon2i", testArgon2i),
        ("testArgon2d", testArgon2d),
        ("testArgon2id", testArgon2id),
    ]

    func testArgon2i() throws {
        try testVariant(Argon2.i)
    }

    func testArgon2d() throws {
        try testVariant(Argon2.d)
    }

    func testArgon2id() throws {
        try testVariant(Argon2.id)
    }

    private func testVariant(_ variant: Argon2) throws {
        let password = [UInt8]("password".utf8)
        let salt = [UInt8]("somesalt".utf8)
        let otherPassword = [UInt8]("drowssap".utf8)

        let result = try variant.hash(password, salt: salt, timeCost: 2, memoryCost: 16, parallelism: 1)
        XCTAssertTrue(variant.verify(result, against: password))
        XCTAssertFalse(variant.verify(result, against: otherPassword))

        XCTAssertThrowsError(try variant.assertVerification(ofHash: result, against: otherPassword), "Verification did not fail for invalid password!") { (err) in
            guard case Argon2Error.verifyMismatch = err else {
                XCTFail("Expected verifyMismatch error!")
                return
            }
        }
    }
}
