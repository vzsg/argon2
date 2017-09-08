import CArgon2

public extension Argon2 {
    public func hash(_ password: [UInt8],
                     salt: [UInt8],
                     timeCost: UInt32,
                     memoryCost: UInt32,
                     parallelism: UInt32) throws -> String {
        var buf = [CChar](repeating: 0, count: 256)

        return try password.withUnsafeBytes { pwd in
            try salt.withUnsafeBytes { slt in
                try buf.withUnsafeMutableBufferPointer { res in
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

                    if let error = Argon2Error(Argon2_ErrorCodes(rawValue: err)) {
                        throw error
                    }

                    return String(validatingUTF8: res.baseAddress!) ?? ""
                }
            }
        }
    }
}
