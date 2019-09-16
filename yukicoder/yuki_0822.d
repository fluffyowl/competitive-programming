import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto K = s[1];

    if (N < K) {
        writeln("INF");
        return;
    }

    int ans = 0;

    foreach (i; 0..(1<<18)) {
        foreach (j; i..i+K+1) {
            if ((i & j) == N) {
                ans += 1;
            }
        }
    }

    ans.writeln;
}

