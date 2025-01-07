const std = @import("std");
const dsa4 = @import("dsa4.zig");

pub fn main() void {
    var allocator = std.heap.page_allocator; // Use a mutable reference

    // Initialize the hash table with a capacity of 10
    var table = dsa4.HashTable.init(&allocator, 10); // Pass a pointer to the allocator

    // Insert some key-value pairs
    table.insert(&allocator, "apple", 1);
    table.insert(&allocator, "banana", 2);

    // Retrieve values
    const appleValue = table.find("apple");
    const bananaValue = table.find("banana");

    if (appleValue) |val| {
        std.debug.print("Value for 'apple': {}\n", .{val});
    } else {
        std.debug.print("'apple' not found\n", .{});
    }

    if (bananaValue) |val| {
        std.debug.print("Value for 'banana': {}\n", .{val});
    } else {
        std.debug.print("'banana' not found\n", .{});
    }

    // Clean up resources
    table.deinit(&allocator); // Pass a pointer to the allocator
}
