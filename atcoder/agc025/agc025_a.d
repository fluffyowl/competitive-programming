import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto N = readln.chomp.to!int;

    int ds(int x) {
        int ret = 0;
        while (x > 0) ret += x % 10, x /= 10;
        return ret;
    }

    int ans = 1 << 29;
    foreach (i; 1..N) {
        int j = N - i;
        ans = min(ans, ds(i) + ds(j));
    }

    ans.writeln;
}
