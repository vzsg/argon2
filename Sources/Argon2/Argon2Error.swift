import CArgon2

public enum Argon2Error: Error {
    case invalidPassword
    case invalidSalt
    case invalidTime
    case invalidMemory
    case invalidParallelism
    case verifyMismatch
    case encodingFailed
    case decodingFailed
    case internalError(Int)
}

internal extension Argon2Error {
    init?(_ code: Argon2_ErrorCodes) {
        switch code {
        case ARGON2_OK:
            return nil
        case ARGON2_PWD_TOO_SHORT, ARGON2_PWD_TOO_LONG:
            self = .invalidPassword
        case ARGON2_SALT_TOO_SHORT, ARGON2_SALT_TOO_LONG:
            self = .invalidSalt
        case ARGON2_TIME_TOO_SMALL, ARGON2_TIME_TOO_LARGE:
            self = .invalidTime
        case ARGON2_MEMORY_TOO_LITTLE, ARGON2_MEMORY_TOO_MUCH:
            self = .invalidMemory
        case ARGON2_LANES_TOO_FEW, ARGON2_LANES_TOO_MANY, ARGON2_THREADS_TOO_FEW, ARGON2_THREADS_TOO_MANY:
            self = .invalidParallelism
        case ARGON2_VERIFY_MISMATCH:
            self = .verifyMismatch
        case ARGON2_ENCODING_FAIL:
            self = .encodingFailed
        case ARGON2_DECODING_FAIL:
            self = .decodingFailed
        default:
            self = .internalError(Int(code.rawValue))
        }
    }
}
