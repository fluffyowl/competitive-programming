import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long MOD = 10^^9 + 7;


void main() {
    auto s = readln.split.map!(to!int);
    auto Q = s[0];
    auto K = s[1];
    auto small = new BinaryHeap!(Array!long, "a < b");
    auto large = new BinaryHeap!(Array!long, "a > b");

    while (Q--) {
        auto q = readln.split.map!(to!long);
        auto t = q[0];
        if (t == 1) {
            auto v = q[1];
            if (small.length < K) {
                small.insert(v);
            } else if (small.front > v) {
                auto w = small.front;
                small.removeFront;
                small.insert(v);
                large.insert(w);
            } else {
                large.insert(v);
            }
        } else {
            if (small.length < K) {
                writeln(-1);
                continue;
            }
            small.front.writeln;
            small.removeFront;
            if (large.length > 0) {
                small.insert(large.front);
                large.removeFront;
            }
        }
    }
}

