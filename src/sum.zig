const expect = @import("std").testing.expect;

pub fn sum(a: i32, b: i32) i32 {
    return a + b;
}

test "sum" {
    try expect(sum(1, 2) == 3);
}
