import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto C = s[1];
    auto L = N.iota.map!(_ => readln.chomp.to!int).array;

    int ans = 0;
    auto rbt = new RedBlackTree!(int, "a < b", true)(L);
    while (!rbt.empty) {
        auto a = rbt.back();
        rbt.removeKey(a);
        auto lb = rbt.lowerBound(C - a);
        if (!lb.empty) {
            auto b = lb.back;
            rbt.removeKey(b);
        }
        ans += 1;
    }

    ans.writeln;
}
