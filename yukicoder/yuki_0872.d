import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

void main() {
    auto N = readln.chomp.to!int;
    auto g = new Tuple!(int, long)[][](N);
    foreach (_; 0..N-1) {
        auto s = readln.split.map!(to!int);
        g[s[0]-1] ~= tuple(s[1]-1, s[2].to!long);
        g[s[1]-1] ~= tuple(s[0]-1, s[2].to!long);
    }

    auto sub = new long[](N);
    long ans = 0;

    void dfs(int n, int p) {
        sub[n] = 1;
        foreach (to; g[n]) {
            int m = to[0];
            long w = to[1];
            if (m == p) continue;
            dfs(m, n);
            ans += sub[m] * (N - sub[m]) * w;
            sub[n] += sub[m];
        }
    }

    dfs(0, -1);
    writeln(ans * 2);
}

