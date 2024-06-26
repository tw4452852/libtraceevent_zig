const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const upstream = b.dependency("upstream", .{});

    const lib = b.addStaticLibrary(.{
        .name = "traceevent",
        .target = target,
        .optimize = optimize,
    });

    const cflags = [_][]const u8{
        "-D_GNU_SOURCE",
    };
    lib.linkLibC();
    lib.addCSourceFiles(.{
        .root = upstream.path(""),
        .files = &.{
            "src/event-parse-api.c",
            "src/event-parse.c",
            "src/event-plugin.c",
            "src/kbuffer-parse.c",
            "src/parse-filter.c",
            "src/parse-utils.c",
            "src/tep_strerror.c",
            "src/trace-seq.c",
        },
        .flags = &cflags,
    });
    lib.addIncludePath(.{ .dependency = .{
        .dependency = upstream,
        .sub_path = "include",
    } });
    lib.addIncludePath(.{ .dependency = .{
        .dependency = upstream,
        .sub_path = "include/traceevent",
    } });

    lib.installHeadersDirectory(upstream.path("include/traceevent"), "", .{});

    b.installArtifact(lib);
}
