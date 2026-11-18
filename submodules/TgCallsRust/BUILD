load("@rules_cc//cc:cc_import.bzl", "cc_import")
load("@rules_cc//cc:objc_library.bzl", "objc_library")
load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

config_setting(
    name = "enabled",
    define_values = {"tgcalls_rust": "true"},
    visibility = ["//visibility:public"],
)

config_setting(
    name = "ios_sim_x86_64",
    values = {"cpu": "ios_x86_64"},
)

cc_import(
    name = "archive",
    static_library = select({
        "//build-system:ios_sim_arm64": "Prepared/simulator/libtgcalls_ffi.a",
        ":ios_sim_x86_64": "Prepared/simulator/libtgcalls_ffi.a",
        "//conditions:default": "Prepared/device/libtgcalls_ffi.a",
    }),
)

objc_library(
    name = "CTgCalls",
    hdrs = [
        "Prepared/headers/TGCallsIOSAudioDevice.h",
        "Prepared/headers/tgcalls.h",
    ],
    enable_modules = True,
    module_name = "CTgCalls",
    sdk_frameworks = ["AVFoundation", "AudioToolbox", "Security", "SystemConfiguration"],
    deps = [":archive"],
    visibility = ["//submodules/TelegramVoip:__pkg__"],
)

swift_library(
    name = "TgCallsRust",
    srcs = ["Prepared/Worker.swift"],
    deps = [":CTgCalls"],
    visibility = ["//submodules/TelegramVoip:__pkg__"],
)

filegroup(
    name = "wasm",
    srcs = ["Prepared/tgcalls-worker.wasm"],
    visibility = ["//Telegram:__pkg__"],
)
