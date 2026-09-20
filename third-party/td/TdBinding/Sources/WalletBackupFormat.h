#pragma once
#include <array>
#include <cstdint>
#include <stdexcept>
#include <string>
#include <string_view>
#include <vector>

// Recovered from WalletBackupCrypto in macOS 12.10.283233.
namespace wallet_backup {
inline void require(bool ok) { if (!ok) throw std::runtime_error("Invalid wallet backup envelope"); }
inline void wipe(std::string &s) {
    volatile char *p = s.empty() ? nullptr : &s[0];
    for (size_t i = 0; i < s.size(); ++i) p[i] = 0;
}
struct Secret {
    std::string value;
    explicit Secret(std::string v): value(std::move(v)) {}
    ~Secret() { wipe(value); }
    Secret(const Secret &) = delete;
    Secret &operator=(const Secret &) = delete;
};
inline uint32_t word(std::string_view s, size_t offset) {
    require(offset <= s.size() && s.size() - offset >= 4);
    uint32_t n = 0;
    for (unsigned i = 0; i < 4; ++i) n |= uint32_t(uint8_t(s[offset+i])) << (8*i);
    return n;
}
inline void appendWord(std::string &s, uint32_t n) {
    for (unsigned i = 0; i < 4; ++i) s.push_back(char(n >> (8*i)));
}
inline std::string packBytes(std::string_view s) {
    require(s.size() <= 0xffffff);
    std::string r;
    if (s.size() < 254) r.push_back(char(s.size()));
    else {
        r.push_back(char(254));
        for (unsigned i = 0; i < 3; ++i) r.push_back(char(s.size() >> (8*i)));
    }
    r.append(s);
    while (r.size() % 4) r.push_back(0);
    return r;
}
inline std::string_view unpackBytes(std::string_view s, size_t offset) {
    require(offset < s.size());
    size_t n = uint8_t(s[offset]), header = 1;
    require(n != 255);
    if (n == 254) {
        require(s.size() - offset >= 4);
        n = word(s, offset) >> 8; header = 4;
    }
    require(n <= s.size() - offset - header);
    size_t end = offset + header + n;
    size_t padded = end + ((4 - ((header+n) % 4)) % 4);
    require(padded == s.size());
    for (size_t i = end; i < padded; ++i) require(s[i] == 0);
    return s.substr(offset + header, n);
}
inline std::string packShare(std::string_view share) {
    require(!share.empty());
    std::string r;
    appendWord(r, 0x8b90dd08);
    r += packBytes(share);
    return r;
}
inline std::string_view unpackShare(std::string_view plain) {
    require(word(plain, 0) == 0x8b90dd08);
    auto share = unpackBytes(plain, 4);
    require(!share.empty());
    return share;
}
struct Envelope {
    std::string_view blob;
    bool wrapped;
    uint32_t index, count, setTag;
};
inline Envelope envelope(std::string_view input) {
    require(input.size() >= 4);
    Envelope e{input, false, 0, 0, 0};
    if (word(input, 0) == 0x1ea87158) {
        e = {unpackBytes(input, 16), true, word(input,4), word(input,8), word(input,12)};
    }
    require(e.blob.size() > 32 && e.blob.size() % 16 == 0);
    return e;
}
inline std::array<Envelope,3> ordered(const std::vector<std::string> &inputs) {
    require(inputs.size() == 3);
    std::array<Envelope,3> result;
    auto first = envelope(inputs[0]);
    std::array<bool,3> seen{};
    for (size_t i = 0; i < 3; ++i) {
        auto e = envelope(inputs[i]);
        require(e.wrapped == first.wrapped);
        size_t index = i;
        if (e.wrapped) {
            require(e.count == 3 && e.index < 3 && e.setTag == first.setTag);
            index = e.index;
        }
        require(!seen[index]); seen[index] = true; result[index] = e;
    }
    return result;
}
inline std::string xorThree(std::string_view a, std::string_view b, std::string_view c) {
    require(!a.empty() && a.size() == b.size() && a.size() == c.size());
    std::string r(a.size(), 0);
    for (size_t i=0; i<a.size(); ++i) r[i] = a[i] ^ b[i] ^ c[i];
    return r;
}
} // namespace wallet_backup
