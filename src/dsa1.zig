const std = @import("std");

pub const Box = struct {
    length: u32,
    width: u32,
    height: u32,
};

fn generateRotations(allocator: std.mem.Allocator, boxes: []const Box) ![]Box {
    var rotations = std.ArrayList(Box).init(allocator);
    defer rotations.deinit();

    for (boxes) |box| {
        try rotations.append(.{ .length = @max(box.length, box.width), .width = @min(box.length, box.width), .height = box.height });

        try rotations.append(.{ .length = @max(box.length, box.height), .width = @min(box.length, box.height), .height = box.width });

        try rotations.append(.{ .length = @max(box.width, box.height), .width = @min(box.width, box.height), .height = box.length });
    }

    return rotations.toOwnedSlice();
}

fn compareBoxBaseArea(context: void, a: Box, b: Box) bool {
    _ = context;
    return (a.length * a.width) > (b.length * b.width);
}

fn canStack(bottom: Box, top: Box) bool {
    return bottom.length > top.length and bottom.width > top.width;
}

pub fn boxStacking(allocator: std.mem.Allocator, boxes: []const Box) !u32 {
    const rotations = try generateRotations(allocator, boxes);
    defer allocator.free(rotations);

    std.mem.sort(Box, rotations, {}, compareBoxBaseArea);

    var maxHeights = try std.ArrayList(u32).initCapacity(allocator, rotations.len);
    defer maxHeights.deinit();

    for (rotations, 0..) |box, i| {
        try maxHeights.append(box.height);
        for (0..i) |j| {
            if (canStack(rotations[j], box)) {
                maxHeights.items[i] = @max(maxHeights.items[i], maxHeights.items[j] + box.height);
            }
        }
    }

    return maxHeights.items[maxHeights.items.len - 1];
}
