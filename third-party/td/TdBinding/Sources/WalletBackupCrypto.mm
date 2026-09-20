#import <TdBinding/WalletBackupCrypto.h>
#import <Security/Security.h>
#include <td/e2e/e2e_api.h>
#include "WalletBackupFormat.h"

namespace {
struct Key {
    int64_t id;
    explicit Key(int64_t value): id(value) {}
    ~Key() { if (id) tde2e_api::key_destroy(id); }
    Key(const Key &) = delete;
    Key &operator=(const Key &) = delete;
};
template <typename T> T take(tde2e_api::Result<T> result) {
    if (!result.is_ok()) throw std::runtime_error("Wallet backup cryptography failed");
    return std::move(result.value());
}
std::string_view view(NSData *data) { return {data.length ? (const char *)data.bytes : "", data.length}; }
NSData *walletNSData(std::string_view bytes) { return [NSData dataWithBytes:bytes.data() length:bytes.size()]; }
void fail(NSError **error) {
    if (error) *error = [NSError errorWithDomain:@"org.telegram.wallet-backup-crypto" code:1 userInfo:@{NSLocalizedDescriptionKey: @"Invalid or undecryptable wallet backup"}];
}
}

@implementation WalletBackupCryptoKeyPair {
    int64_t _privateKeyId;
    NSData *_publicKey;
}
- (instancetype)initWithKey:(int64_t)key publicKey:(NSData *)publicKey {
    self = [super init];
    if (self) { _privateKeyId = key; _publicKey = publicKey; }
    return self;
}
+ (instancetype)generateWithError:(NSError **)error {
    try {
        Key key(take(tde2e_api::key_generate_temporary_private_key()));
        auto pub = take(tde2e_api::key_to_public_key(key.id));
        wallet_backup::require(pub.size() == 32);
        auto result = [[self alloc] initWithKey:key.id publicKey:walletNSData(pub)];
        if (result) key.id = 0;
        return result;
    } catch (const std::exception &) { fail(error); return nil; }
}
- (NSData *)publicKey { return _publicKey; }
- (void)dealloc { if (_privateKeyId) tde2e_api::key_destroy(_privateKeyId); }
- (NSData *)decryptAndCombineEnvelopes:(NSArray<NSData *> *)envelopes error:(NSError **)error {
    try {
        wallet_backup::require(envelopes.count == 3 && _privateKeyId != 0);
        std::vector<std::string> input;
        for (NSData *value in envelopes) input.emplace_back(view(value));
        auto ordered = wallet_backup::ordered(input);
        std::array<std::string,3> shares;
        // Wipe all shares on success and exception.
        struct Cleanup { std::array<std::string,3> &s; ~Cleanup() { for (auto &v:s) wallet_backup::wipe(v); } } cleanup{shares};
        for (size_t i=0; i<3; ++i) {
            auto blob = ordered[i].blob;
            Key pub(take(tde2e_api::key_from_public_key(blob.substr(0,32))));
            Key shared(take(tde2e_api::key_from_ecdh(_privateKeyId, pub.id)));
            wallet_backup::Secret plain(take(tde2e_api::decrypt_message_for_one(shared.id, blob.substr(32))));
            shares[i] = wallet_backup::unpackShare(plain.value);
        }
        wallet_backup::Secret secret(wallet_backup::xorThree(shares[0],shares[1],shares[2]));
        return walletNSData(secret.value);
    } catch (const std::exception &) { fail(error); return nil; }
}
@end

@implementation WalletBackupCrypto
+ (NSArray<NSData *> *)encryptSecret:(NSData *)secret holderPublicKeys:(NSArray<NSData *> *)keys error:(NSError **)error {
    try {
        wallet_backup::require(secret.length > 0 && secret.length <= 0xffffff && keys.count == 3);
        for (NSData *key in keys) wallet_backup::require(key.length == 32);
        wallet_backup::Secret a(std::string(secret.length,0)), b(std::string(secret.length,0));
        wallet_backup::require(SecRandomCopyBytes(kSecRandomDefault,a.value.size(),a.value.data()) == errSecSuccess);
        wallet_backup::require(SecRandomCopyBytes(kSecRandomDefault,b.value.size(),b.value.data()) == errSecSuccess);
        wallet_backup::Secret c(wallet_backup::xorThree(view(secret),a.value,b.value));
        std::array<std::string_view,3> shares{a.value,b.value,c.value};
        NSMutableArray<NSData *> *result = [NSMutableArray arrayWithCapacity:3];
        for (size_t i=0; i<3; ++i) {
            Key ephemeral(take(tde2e_api::key_generate_temporary_private_key()));
            auto pubBytes = take(tde2e_api::key_to_public_key(ephemeral.id));
            wallet_backup::require(pubBytes.size() == 32);
            Key holder(take(tde2e_api::key_from_public_key(view(keys[i]))));
            Key shared(take(tde2e_api::key_from_ecdh(ephemeral.id,holder.id)));
            wallet_backup::Secret plain(wallet_backup::packShare(shares[i]));
            auto encrypted = take(tde2e_api::encrypt_message_for_one(shared.id,plain.value));
            [result addObject:walletNSData(pubBytes + encrypted)];
        }
        return result;
    } catch (const std::exception &) { fail(error); return nil; }
}
@end
