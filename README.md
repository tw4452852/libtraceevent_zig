# libtraceevent package for zig

This is [libtraceevent](https://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git/),
packaged for [Zig](https://ziglang.org/).

## How to use it

First, update your `build.zig.zon`:

```
zig fetch --save https://github.com/tw4452852/libtraceevent_zig/archive/refs/tags/1.8.3.tar.gz
```

Next, add this snippet to your `build.zig` script:

```zig
const libtraceevent_dep = b.dependency("libtraceevent", .{
    .target = target,
    .optimize = optimize,
});
your_compilation.linkLibrary(libtraceevent_dep.artifact("traceevent"));
```

This will add libtraceevent as a static library to `your_compilation`.
