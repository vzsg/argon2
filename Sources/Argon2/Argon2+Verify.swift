import CArgon2

public extension Argon2 {
    public func verify(_ hash: String, against password: [UInt8]) -> Bool {
        return hash.withCString { h in
            password.withUnsafeBytes { pwd in
                self.verifyFn(h, pwd.baseAddress, password.count) == ARGON2_OK.rawValue
            }
        }
    }

    public func assertVerification(ofHash hash: String, against password: [UInt8]) throws {
        try hash.withCString { h in
            try password.withUnsafeBytes { pwd in
                let res = self.verifyFn(h, pwd.baseAddress, password.count)

                if let error = Argon2Error(Argon2_ErrorCodes(rawValue: res)) {
                    throw error
                }
            }
        }
    }
}
