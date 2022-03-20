const zsum = @import("sum.zig");
const ffi = @import("ffi.zig");

const py = ffi.py;
const PyObject = ffi.PyObject;
const PyMethodDef = ffi.PyMethodDef;
const PyModuleDef = ffi.PyModuleDef;

fn _sum(_: [*c]PyObject, args: [*c]PyObject) callconv(.C) [*c]PyObject {
    var a: c_long = undefined;
    var b: c_long = undefined;
    if (py.PyArg_ParseTuple(args, "ll", &a, &b) == 0) return null;
    return py.PyLong_FromLong(zsum.sum(@intCast(i32, a), @intCast(i32, b)));
}

var methods = [_:PyMethodDef{}]PyMethodDef{
    PyMethodDef{
        .ml_name = "sum",
        .ml_meth = _sum,
        .ml_flags = py.METH_VARARGS,
        .ml_doc = "Add two numbers.",
    },
};

var module = PyModuleDef{
    .m_name = "sum",
    .m_methods = &methods,
};

export fn PyInit_libsum() *PyObject {
    return py.PyModule_Create(@ptrCast([*c]py.struct_PyModuleDef, &module));
}
