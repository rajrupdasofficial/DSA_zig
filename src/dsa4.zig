const std = @import("std");

const Node = struct {
    key: []const u8,
    value: i32,
    next: ?*Node,
};

const Bucket = struct {
    head: ?*Node,

    pub fn init() Bucket {
        return Bucket{ .head = null };
    }

    pub fn insert(self: *Bucket, allocator: *std.mem.Allocator, key: []const u8, value: i32) void {
        // Create a new node
        const newNode = allocator.create(Node) catch |err| {
            std.debug.print("Failed to allocate memory for Node: {}\n", .{err});
            return;
        };
        newNode.* = Node{ .key = key, .value = value, .next = self.head };
        self.head = newNode;
    }

    pub fn find(self: *Bucket, key: []const u8) ?i32 {
        var current = self.head;
        while (current) |node| {
            if (std.mem.eql(u8, node.key, key)) {
                return node.value; // Key found, return value
            }
            current = node.next;
        }
        return null; // Key not found
    }

    pub fn deinit(self: *Bucket, allocator: *std.mem.Allocator) void {
        var current = self.head;
        while (current) |node| {
            const next = node.next;
            allocator.destroy(node);
            current = next;
        }
    }
};

pub const HashTable = struct {
    buckets: []?*Bucket,
    capacity: usize,

    pub fn init(allocator: *std.mem.Allocator, capacity: usize) !HashTable { // Note the return type change
        const buckets = try allocator.alloc(?*Bucket, capacity); // Handle allocation error
        for (buckets) |*bucket| {
            bucket.* = try allocator.create(Bucket); // Handle allocation error
            bucket.*.init();
        }
        return HashTable{
            .buckets = buckets,
            .capacity = capacity,
        };
    }

    pub fn insert(self: *HashTable, allocator: *std.mem.Allocator, key: []const u8, value: i32) void {
        const index = self.hash(key);

        // Ensure the bucket exists before inserting
        if (self.buckets[index] == null) {
            self.buckets[index] = try allocator.create(Bucket); // Handle allocation error
            self.buckets[index].*.init();
        }

        self.buckets[index].*.insert(allocator, key, value);
    }

    pub fn find(self: *HashTable, key: []const u8) ?i32 {
        const index = self.hash(key);

        // Ensure the bucket exists before finding
        if (self.buckets[index] != null) {
            return self.buckets[index].*.find(key);
        }

        return null; // Bucket not found
    }

    fn hash(self: *HashTable, key: []const u8) usize {
        var hash_value: usize = 0;
        for (key) |c| {
            hash_value += c;
        }
        return hash_value % self.capacity;
    }

    pub fn deinit(self: *HashTable, allocator: *std.mem.Allocator) void {
        for (self.buckets) |*bucket| {
            if (bucket != null) { // Check if bucket is not null before deinitializing
                bucket.*.deinit(allocator);
                allocator.destroy(bucket);
            }
        }
        allocator.free(self.buckets);
    }
};
