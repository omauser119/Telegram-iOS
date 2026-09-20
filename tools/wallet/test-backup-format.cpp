#include "../../third-party/td/TdBinding/Sources/WalletBackupFormat.h"
#include <cassert>
#include <functional>
#include <iostream>
using namespace wallet_backup;
static void rejects(const std::function<void()> &f) {
    bool rejected = false;
    try { f(); } catch (const std::runtime_error &) { rejected = true; }
    assert(rejected);
}
static std::string wrap(const std::string &blob, uint32_t i, uint32_t count=3, uint32_t tag=7) {
    std::string s;
    for (auto n : {0x1ea87158u,i,count,tag}) appendWord(s,n);
    return s + packBytes(blob);
}
int main() {
    for (size_t n : {1u,2u,3u,4u,253u,254u,255u,256u,1024u}) {
        std::string secret(n,'S'), a(n,'A'), b(n,'B');
        auto c = xorThree(secret,a,b);
        assert(xorThree(a,b,c) == secret);
        auto packed = packShare(secret);
        assert(unpackShare(packed) == secret);
        for (size_t k=0; k<packed.size(); ++k) rejects([&]{ unpackShare(std::string_view(packed).substr(0,k)); });
        rejects([&]{ unpackShare(packed + "x"); });
    }
    std::string blob(80,'x');
    std::vector<std::string> valid{wrap(blob,2),wrap(blob,0),wrap(blob,1)};
    auto parsed = ordered(valid);
    assert(parsed[0].index == 0 && parsed[1].index == 1 && parsed[2].index == 2);
    rejects([&]{ ordered({wrap(blob,0),wrap(blob,0),wrap(blob,2)}); });
    rejects([&]{ ordered({wrap(blob,0),wrap(blob,1),wrap(blob,2,3,8)}); });
    rejects([&]{ ordered({wrap(blob,0),wrap(blob,1),blob}); });
    rejects([&]{ ordered({wrap(blob,0),wrap(blob,1),wrap(blob,2,2)}); });
    rejects([&]{ ordered({blob,blob}); });
    rejects([&]{ envelope(std::string(32,'x')); });
    rejects([&]{ envelope(std::string(79,'x')); });
    rejects([&]{ xorThree("a","bb","c"); });
    auto padded = packShare("xx");
    padded.back() = 1;
    rejects([&]{ unpackShare(padded); });
    std::cout << "Backup framing/XOR: valid, truncated, duplicate, mixed, padding checks passed\n";
}
