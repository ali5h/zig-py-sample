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
Pure Zig part is in `src/sum.zig`, Python ffi is in `src/ffi.zig` and the extension is in `src/main.zig`.
