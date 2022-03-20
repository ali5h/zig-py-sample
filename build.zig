const std = @import("std");

const pkgs = struct {
    const python = std.build.Pkg{
        .name = "python3.8",
        .path = .{ .path = "./src/python3.8.zig" },
    };
};

pub fn build(b: *std.build.Builder) void {
    const mode = b.standardReleaseOptions();

    const lib = b.addSharedLibrary("sum", "src/pysum.zig", .unversioned);
    lib.setBuildMode(mode);
    lib.addPackage(pkgs.python);
    lib.linkLibC();
    lib.install();

    const exe = b.addExecutable("callpy", "src/callpy.zig");
    exe.addPackage(pkgs.python);
    exe.addIncludeDir("/usr/include/python3.8");
    exe.linkSystemLibrary("python3.8");
    exe.linkLibC();
    exe.install();

    const main_tests = b.addTest("src/sum.zig");
    main_tests.setBuildMode(mode);

    const test_step = b.step("test", "Run library tests");
    test_step.dependOn(&main_tests.step);
}
