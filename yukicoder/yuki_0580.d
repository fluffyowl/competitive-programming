import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;


void main() {
    auto s = readln.split;
    auto N = s[0].to!int;
    auto M = s[1].to!int;
    auto S = new Tuple!(int, int)[](M);
    foreach (i; 0..M) {
        s = readln.split;
        int d1 = s[0].to!int;
        int h1 = s[1].split(":")[0].to!int;
        int m1 = s[1].split(":")[1].to!int;
        int d2 = s[2].to!int;
        int h2 = s[3].split(":")[0].to!int;
        int m2 = s[3].split(":")[1].to!int;
        S[i] = tuple(d1*60*24+h1*60+m1, d2*60*24+h2*60+m2);
    }
    S.sort!"a[1] == b[1] ? a[0] < b[0] : a[1] < b[1]";

    int ans = 0;
    auto rbt = new RedBlackTree!(int, "a < b", true)();

    foreach (seg; S) {
        if (rbt.empty) {
            ans += 1;
            rbt.insert(seg[1]);
        } else {
            auto lb = rbt.lowerBound(seg[0]);
            if (!lb.empty) {
                ans += 1;
                int x = lb.back;
                rbt.removeKey(x);
                rbt.insert(seg[1]);
            } else if (rbt.length < N) {
                ans += 1;
                rbt.insert(seg[1]);
            }
        }
    }

    ans.writeln;
}

