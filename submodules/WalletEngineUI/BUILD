load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "WalletEngineUI",
    module_name = "WalletEngineUI",
    srcs = glob(["Sources/**/*.swift"]),
    copts = ["-swift-version", "6", "-default-isolation", "MainActor"],
    deps = ["//third-party/WalletEngineBindings:WalletEngineFFI"],
    visibility = ["//visibility:public"],
)
