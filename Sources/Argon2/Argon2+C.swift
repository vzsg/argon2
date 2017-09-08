import CArgon2

typealias HashFunction = (_ t: UInt32,
    _ m: UInt32,
    _ par: UInt32,
    _ pwd: UnsafeRawPointer?,
    _ pwdlen: Int,
    _ salt: UnsafeRawPointer?,
    _ saltlen: Int,
    _ hashlen: Int,
    _ enc: UnsafeMutablePointer<Int8>?,
    _ enclen: Int) -> Int32

typealias VerifyFunction = (_ enc: UnsafePointer<Int8>?, _ pwd: UnsafeRawPointer?, _ pwdlen: Int) -> Int32

internal extension Argon2 {
    var hashFn: HashFunction {
        switch self {
        case .d:
            return { argon2d_hash_encoded($0, $1, $2, $3, $4, $5, $6, $7, $8, $9) }
        case .i:
            return { argon2i_hash_encoded($0, $1, $2, $3, $4, $5, $6, $7, $8, $9) }
        case .id:
            return { argon2id_hash_encoded($0, $1, $2, $3, $4, $5, $6, $7, $8, $9) }
        }
    }

    var verifyFn: VerifyFunction {
        switch self {
        case .d:
            return { argon2d_verify($0, $1, $2) }
        case .i:
            return { argon2i_verify($0, $1, $2) }
        case .id:
            return { argon2id_verify($0, $1, $2) }
        }
    }
}
