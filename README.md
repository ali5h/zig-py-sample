# Sample Python Extension in Zig

This is tested on Ubuntu with `python3.8` installed.

```
# build the extension
$ zig build
# run zig tests
$ zig build test
# run python tests
$ pytest
```

## logical division of the code
- Pure Zig part is in `src/sum.zig`
- Python ffi is used in `src/ffi.zig` and translated headers are in `src/python3.8.zig`
- The extension is in `src/pysum.zig`
- Sample app to call python code is in `src/callpy.zig`

## python ffi

`python3.8.zig` is generated by running
```
$ zig translate-c /usr/include/python3.8/Python.h -I/usr/include/python3.8 -I /usr/include -I /usr/include/x86_64-linux-gnu/ -D__sched_priority=0 -DNDEBUG > src/python3.8.zig
```
