import Foundation
import MtProtoKit

// Debug Accounts > Flash. This configuration is applied per account record.
enum FlashNetworkConfiguration {
    static let datacenterId: Int = 2
    static let host = "31.76.29.36"
    static let port: UInt16 = 2398
    // SPKI SHA256: 55e1970fe35d1b3d0ad3c1e63d41d779ae5d986961036620f2253b960fdbf142
    static let publicKey = """
    -----BEGIN RSA PUBLIC KEY-----
    MIIBCgKCAQEAvXoliv9doaaoZZTh2xz5eNRaI24REVge4vpfc7XSbm33no1Iz8w5
    Uyu8BoLYkz25oBWzfPgSFciybGYzcDFNJM0wTjq6Rj3ELtr+TZ/kizy3UWbxzbNv
    ajfyyhLC48QcSLhSEA3Jp4vNpsh3oRjhhnEyPlCOM/WZkZ4LeZhdm+OUHzPtViYj
    hIlj7wSlU/85KwRHWD9pRDHTfa3RqNkJvCCJn9olUcISjPWy5CTglapXjdkpqwWz
    xcDOUF+lSWF9jIBks/zqy4UOfgct/9jBlInIO9kB3sfO2yjpl2x1ZxKnYZrsDNc0
    TL70pdpTLJl2X0VRIY5hAshmjoUxcum5dQIDAQAB
    -----END RSA PUBLIC KEY-----
    """

    static func address() -> MTDatacenterAddress {
        return MTDatacenterAddress(ip: host, port: port, preferForMedia: false, restrictToTcp: true, cdn: false, preferForProxy: false, secret: nil)
    }
}
