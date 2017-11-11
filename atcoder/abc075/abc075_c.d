import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto edges = new int[][](N);
    Tuple!(int, int)[] hoge;
    foreach (_; 0..M) {
        s = readln.split.map!(to!int);
        edges[s[0]-1] ~= s[1]-1;
        edges[s[1]-1] ~= s[0]-1;
        hoge ~= tuple(s[0]-1, s[1]-1);
    }

    auto used = new bool[](N);
    void dfs(int n, int x, int y) {
        if (used[n]) return;
        used[n] = true;
        foreach (m; edges[n]) {
            if (x == n && y == m) continue;
            if (x == m && y == n) continue;
            if (!used[m]) dfs(m, x, y);
        }
    }

    int ans = 0;
    foreach (i; 0..M) {
        used.fill(false);
        dfs(0, hoge[i][0], hoge[i][1]);
        if (used.sum != N) ans += 1;
    }

    ans.writeln;
}
