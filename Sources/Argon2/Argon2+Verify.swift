import CArgon2

public extension Argon2 {
    public func verify(_ hash: String, against password: [UInt8]) -> Bool {
        return hash.withCString { h in
            password.withUnsafeBytes { pwd in
                self.verifyFn(h, pwd.baseAddress, password.count) == ARGON2_OK.rawValue
            }
        }
    }
}
