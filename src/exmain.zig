// const dsa1 = @import("dsa1.zig");
//const dsa2 = @import("dsa2.zig");
// const dsa3 = @import("dsa3.zig");

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
// var gpa = std.heap.GeneralPurposeAllocator(.{}){};
// const allocator = gpa.allocator();
// defer _ = gpa.deinit();

// var queue = dsa2.Queue(i32).init(allocator);
// defer queue.deinit();

// try queue.enqueue(10);
// try queue.enqueue(20);
// try queue.enqueue(30);

// std.debug.print("Front: {?}\n", .{queue.front()});
// std.debug.print("Dequeued: {?}\n", .{queue.dequeue()});
// dsa3.zig
// Use general-purpose allocator

// Use general-purpose allocator with leak detection
// var gpa = std.heap.GeneralPurposeAllocator(.{
//     .verbose_log = true,
//     .check_integrity = true,
// }){};
// const allocator = gpa.allocator();
// defer {
//     const leaked = gpa.deinit();
//     if (leaked) {
//         std.debug.print("Memory leak detected!\n", .{});
//     }
// }

// Create BST
// var bst = dsa3.BinarySearchTree.init(allocator);
// defer bst.deinit(); // Ensure proper memory cleanup

// // Insert values
// try bst.insert(50);
// try bst.insert(30);
// try bst.insert(70);
// try bst.insert(20);
// try bst.insert(40);
// try bst.insert(60);
// try bst.insert(80);

// // Print inorder traversal (sorted order)
// std.debug.print("Inorder Traversal: ", .{});
// bst.inorderTraversal(bst.root);
// std.debug.print("\n", .{});

// // Search examples
// std.debug.print("Search 40: {}\n", .{bst.search(40)});
// std.debug.print("Search 90: {}\n", .{bst.search(90)});
