import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

immutable int INF = 1 << 28;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto L = s[1];

    auto table = new bool[](L+1);
    table.fill(true);
    for (int i = 2; i <= L; ++i) {
        if (!table[i]) continue;
        for (int j = i+i; j <= L; j += i) {
            table[j] = false;
        }
    }

    long ans = 0;
    foreach (d; 2..L+1) {
        if (!table[d]) continue;
        long x = 1L * (N-1) * d;
        ans += max(0, L-x+1);
    }

    ans.writeln;
}

