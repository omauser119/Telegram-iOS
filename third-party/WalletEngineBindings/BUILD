load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")
load("@rules_cc//cc:cc_import.bzl", "cc_import")

cc_import(
    name = "wallet_engine_binary",
    static_library = "Generated/libwallet_engine.a",
)
objc_library(
    name = "wallet_engineFFI",
    module_name = "wallet_engineFFI",
    enable_modules = True,
    hdrs = ["Generated/wallet_engineFFI.h"],
    includes = ["Generated"],
    deps = [":wallet_engine_binary"],
    linkopts = ["-framework", "Security", "-framework", "SystemConfiguration", "-liconv"],
)
swift_library(
    name = "WalletEngineFFI",
    module_name = "WalletEngineFFI",
    srcs = ["Generated/WalletEngineFFI.swift"],
    copts = ["-swift-version", "6"],
    deps = [":wallet_engineFFI"],
    visibility = ["//visibility:public"],
)
