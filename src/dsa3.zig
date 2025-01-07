const std = @import("std");

pub const Node = struct {
    value: i32,
    left: ?*Node,
    right: ?*Node,

    pub fn init(val: i32) Node {
        return Node{
            .value = val,
            .left = null,
            .right = null,
        };
    }
};

pub const BinarySearchTree = struct {
    root: ?*Node,
    allocator: std.mem.Allocator,

    pub fn init(allocator: std.mem.Allocator) BinarySearchTree {
        return BinarySearchTree{
            .root = null,
            .allocator = allocator,
        };
    }

    pub fn insert(self: *BinarySearchTree, value: i32) !void {
        self.root = try self.insertRecursive(self.root, value);
    }

    fn insertRecursive(self: *BinarySearchTree, node: ?*Node, value: i32) !?*Node {
        if (node == null) {
            const newNode = try self.allocator.create(Node);
            newNode.* = Node.init(value);
            return newNode;
        }

        var currentNode = node.?;
        if (value < currentNode.value) {
            currentNode.left = try self.insertRecursive(currentNode.left, value);
        } else if (value > currentNode.value) {
            currentNode.right = try self.insertRecursive(currentNode.right, value);
        }

        return currentNode;
    }

    pub fn inorderTraversal(self: *BinarySearchTree, node: ?*Node) void {
        if (node == null) return;

        self.inorderTraversal(node.?.left);
        std.debug.print("{d} ", .{node.?.value});
        self.inorderTraversal(node.?.right);
    }

    pub fn search(self: *BinarySearchTree, value: i32) bool {
        return self.searchRecursive(self.root, value);
    }

    fn searchRecursive(self: *BinarySearchTree, node: ?*Node, value: i32) bool {
        if (node == null) return false;

        const currentNode = node.?;
        if (value == currentNode.value) return true;

        if (value < currentNode.value) {
            return self.searchRecursive(currentNode.left, value);
        } else {
            return self.searchRecursive(currentNode.right, value);
        }
    }

    pub fn deinit(self: *BinarySearchTree) void {
        self.destroyTree(self.root);
        self.root = null;
    }

    fn destroyTree(self: *BinarySearchTree, node: ?*Node) void {
        if (node) |n| {
            self.destroyTree(n.left);
            self.destroyTree(n.right);
            self.allocator.destroy(n);
        }
    }
};
