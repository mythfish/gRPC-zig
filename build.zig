const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const spice_dep = b.dependency("spice", .{});
    const spice_mod = spice_dep.module("spice");

    _ = b.addModule("grpczig", .{ .root_source_file = b.path("src/main.zig") });
    const lib = b.addStaticLibrary(.{
        .name = "grpczig",
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });

    lib.root_module.addImport("spice", spice_mod);
    b.installArtifact(lib);

    // // build server lib
    // const server_lib = b.addStaticLibrary(.{
    //     .name = "server",
    //     .root_source_file = b.path("src/server.zig"),
    //     .target = target,
    //     .optimize = optimize,
    //     .version = .{ .major = 0, .minor = 1, .patch = 0 },
    // });
    // server_lib.root_module.addImport("spice", spice_mod);
    // b.installArtifact(server_lib);

    // // build client lib
    // const client_lib = b.addStaticLibrary(.{
    //     .name = "client",
    //     .root_source_file = b.path("src/client.zig"),
    //     .target = target,
    //     .optimize = optimize,
    //     .version = .{ .major = 0, .minor = 1, .patch = 0 },
    // });
    // client_lib.root_module.addImport("spice", spice_mod);
    // b.installArtifact(client_lib);
}
