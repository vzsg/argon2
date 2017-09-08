import CArgon2

public extension Argon2 {
    public func hash(_ password: [UInt8],
                     salt: [UInt8],
                     timeCost: UInt32,
                     memoryCost: UInt32,
                     parallelism: UInt32) -> String? {
        var buf = [CChar](repeating: 0, count: 256)

        return password.withUnsafeBytes { pwd in
            salt.withUnsafeBytes { slt in
                buf.withUnsafeMutableBufferPointer { res in
                    let err = self.hashFn(timeCost,
                                       1 << memoryCost,
                                       parallelism,
                                       pwd.baseAddress,
                                       password.count,
                                       slt.baseAddress,
                                       salt.count,
                                       32,
                                       res.baseAddress,
                                       buf.count - 1)

                    guard err == ARGON2_OK.rawValue else {
                        return nil
                    }

                    return String(validatingUTF8: res.baseAddress!)
                }
            }
        }
    }
}
