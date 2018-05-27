import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    immutable long MAX = 10L^18+10;

    auto s = readln.split.map!(to!long);
    auto D = s[0];
    auto Q = s[1];
    auto rbt = redBlackTree!(Tuple!(long, long))();
    long ans = 0;

    while (Q--) {
        s = readln.split.map!(to!long);
        auto a = s[0];
        auto b = s[1];
        auto lb = rbt.lowerBound(tuple(a+1, b));
        if (!lb.empty && lb.back[1] >= a-1) {
            a = min(a, lb.back[0]);
            b = max(b, lb.back[1]);
            rbt.removeKey(lb.back);
        }

        auto ub = rbt.upperBound(tuple(a, b));
        Tuple!(long, long)[] to_remove;

        foreach (x; ub) {
            if (x[0] > b + 1) break;
            a = min(a, x[0]);
            b = max(b, x[1]);
            to_remove ~= x;
        }

        foreach (x; to_remove) {
            rbt.removeKey(x);
        }

        ans = max(ans, b - a + 1);
        ans.writeln;
        rbt.insert(tuple(a, b));
    }
}
