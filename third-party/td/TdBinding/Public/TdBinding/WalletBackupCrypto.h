#pragma once
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
// Experimental compatibility API reconstructed from the macOS client.
@interface WalletBackupCryptoKeyPair : NSObject
@property (nonatomic, readonly) NSData *publicKey;
+ (nullable instancetype)generateWithError:(NSError **)error;
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
- (nullable NSData *)decryptAndCombineEnvelopes:(NSArray<NSData *> *)envelopes error:(NSError **)error;
@end

@interface WalletBackupCrypto : NSObject
+ (nullable NSArray<NSData *> *)encryptSecret:(NSData *)secret holderPublicKeys:(NSArray<NSData *> *)keys error:(NSError **)error;
@end
NS_ASSUME_NONNULL_END
