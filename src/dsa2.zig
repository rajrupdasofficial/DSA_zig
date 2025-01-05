const std = @import("std");

pub fn Queue(comptime T: type) type {
    return struct {
        const Self = @This();
        items: std.ArrayList(T),

        pub fn init(allocator: std.mem.Allocator) Self {
            return Self{ .items = std.ArrayList(T).init(allocator) };
        }

        pub fn enqueue(self: *Self, item: T) !void {
            try self.items.append(item);
        }

        pub fn dequeue(self: *Self) ?T {
            if (self.items.items.len == 0) return null;
            return self.items.orderedRemove(0);
        }

        pub fn isEmpty(self: *const Self) bool {
            return self.items.items.len == 0;
        }

        pub fn front(self: *const Self) ?T {
            if (self.items.items.len == 0) return null;
            return self.items.items[0];
        }

        pub fn deinit(self: *Self) void {
            self.items.deinit();
        }
    };
}
