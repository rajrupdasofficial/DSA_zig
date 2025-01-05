const std = @import("std");
// const dsa1 = @import("dsa1.zig");
const dsa2 = @import("dsa2.zig");
pub fn main() !void {
    //dsa1 3d box solution
    // var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    // defer _ = gpa.deinit();
    // const allocator = gpa.allocator();

    // const boxes = [_]dsa1.Box{
    //     .{ .length = 4, .width = 3, .height = 2 },
    //     .{ .length = 5, .width = 4, .height = 3 },
    // };

    // const maxHeight = try dsa1.boxStacking(allocator, &boxes);
    // std.debug.print("Max Stack Height: {}\n", .{maxHeight});

    //dsa2.zig
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    defer _ = gpa.deinit();

    var queue = dsa2.Queue(i32).init(allocator);
    defer queue.deinit();

    try queue.enqueue(10);
    try queue.enqueue(20);
    try queue.enqueue(30);

    std.debug.print("Front: {?}\n", .{queue.front()});
    std.debug.print("Dequeued: {?}\n", .{queue.dequeue()});
}
