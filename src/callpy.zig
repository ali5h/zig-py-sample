const ffi = @import("ffi.zig");
const std = @import("std");

const py = ffi.py;

pub fn main() void {
    const code =
        \\from time import time,ctime
        \\print('Today is', ctime(time()))
    ;
    py.Py_Initialize();
    if (py.PyRun_SimpleString(code) != 0) {
        std.os.exit(120);
    }
    if (py.Py_FinalizeEx() != 0) {
        std.os.exit(120);
    }
}
