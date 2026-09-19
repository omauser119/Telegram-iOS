// Experimental read-only surface. Constructor IDs were rechecked against the
// macOS 12.10.283233 serializer, accounting for Swift's string header offset.
// Do not add mutating requests until their entire wire schema is verified.
public enum WalletExperimentalApi {
    public static func proofChallengeConstructor() -> (FunctionDescription, Buffer, DeserializeFunctionResponse<Int32>) {
        let buffer = Buffer()
        buffer.appendInt32(Int32(bitPattern: 0x2025e697))
        return (FunctionDescription(name: "wallet.getProofChallenge", parameters: []), buffer, DeserializeFunctionResponse { buffer in
            // Connectivity diagnostic only; this is not an ownership proof and
            // must never be used to authorize or sign a transfer.
            return BufferReader(buffer).readInt32()
        })
    }
}
