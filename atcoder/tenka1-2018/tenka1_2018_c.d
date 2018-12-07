import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto N = readln.chomp.to!int;
    auto A = N.iota.map!(_ => readln.chomp.to!long).array;
    A.sort();

    auto a = A.front;
    auto b = A.back;
    auto ans = b - a;

    for (int x = 1, y = N - 2; x <= y; ) {
        auto ax = abs(a - A[x]);
        auto ay = abs(a - A[y]);
        auto bx = abs(b - A[x]);
        auto by = abs(b - A[y]);
        if (max(ax, ay) >= max(bx, by)) {
            ans += max(ax, ay);
            if (ax >= ay) {
                a = A[x];
                x += 1;
            } else {
                a = A[y];
                y -= 1;
            }
        } else {
            ans += max(bx, by);
            if (bx >= by) {
                b = A[x];
                x += 1;
            } else {
                b = A[y];
                y -= 1;
            }
        }
    }

    ans.writeln;
}
