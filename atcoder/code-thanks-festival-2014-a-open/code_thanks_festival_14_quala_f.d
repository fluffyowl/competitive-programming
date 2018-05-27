import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto G = new int[][](N);
    foreach (_; 0..M) {
        s = readln.split.map!(to!int);
        G[s[1]-1] ~= s[0]-1;
    }

    auto used = new bool[](N);
    int dfs(int n, int p) {
        if (used[n]) return 0;
        used[n] = true;
        int ret = 1;
        foreach (m; G[n]) if (!used[m]) ret += dfs(m, n);
        return ret;
    }

    dfs(0, -1).writeln;
}
