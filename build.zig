const std = @import("std");

pub fn build(b: *std.build.Builder) void {
    const mode = b.standardReleaseOptions();

    const lib = b.addSharedLibrary("sum", "src/main.zig", .unversioned);
    lib.setBuildMode(mode);

    // from python3-config
    lib.addIncludeDir("/usr/include/");
    lib.addIncludeDir("/usr/include/python3.8");
    lib.addIncludeDir("/usr/include/x86_64-linux-gnu/");
    lib.addLibPath("/usr/lib");
    lib.addLibPath("/usr/lib/python3.8/config-3.8-x86_64-linux-gnu");
    lib.linkSystemLibrary("crypt");
    lib.linkSystemLibrary("pthread");
    lib.linkSystemLibrary("m");
    lib.linkSystemLibrary("dl");
    lib.linkSystemLibrary("util");
    lib.install();

    const main_tests = b.addTest("src/sum.zig");
    main_tests.setBuildMode(mode);

    const test_step = b.step("test", "Run library tests");
    test_step.dependOn(&main_tests.step);
}
