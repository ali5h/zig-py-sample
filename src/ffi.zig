pub const py = @cImport({
    @cDefine("PY_SSIZE_T_CLEAN", "1");
    @cInclude("Python.h");
});

pub const PyObject = py.PyObject;

pub const PyMethodDef = extern struct {
    ml_name: [*c]const u8 = null,
    ml_meth: py.PyCFunction = null,
    ml_flags: c_int = 0,
    ml_doc: [*c]const u8 = null,
};

pub const PyModuleDef_Base = extern struct {
    ob_base: PyObject = PyObject,
    m_init: ?fn () callconv(.C) [*c]PyObject = null,
    m_index: py.Py_ssize_t = 0,
    m_copy: [*c]PyObject = null,
};

pub const PyModuleDef_HEAD_INIT = PyModuleDef_Base{ .ob_base = PyObject{
    .ob_refcnt = 1,
    .ob_type = null,
} };

pub const PyModuleDef = extern struct {
    // m_base: py.PyModuleDef_Base,
    m_base: PyModuleDef_Base = PyModuleDef_HEAD_INIT,
    m_name: [*c]const u8,
    m_doc: [*c]const u8 = null,
    m_size: py.Py_ssize_t = -1,
    m_methods: [*]PyMethodDef,
    m_slots: [*c]py.struct_PyModuleDef_Slot = null,
    m_traverse: py.traverseproc = null,
    m_clear: py.inquiry = null,
    m_free: py.freefunc = null,
};
