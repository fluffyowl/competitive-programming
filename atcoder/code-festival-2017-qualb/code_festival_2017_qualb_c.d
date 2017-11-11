import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto edges = new int[][](N);
    foreach (_; 0..M) {
        s = readln.split.map!(to!int);
        edges[s[0]-1] ~= s[1]-1;
        edges[s[1]-1] ~= s[0]-1;
    }
    auto used = new bool[][](N, 2);

    void dfs(int n, int x) {
        if (used[n][x]) return;
        used[n][x] = true;
        foreach (m; edges[n]) dfs(m, x^1);
    }

    dfs(0, 0);
    long a = used.map!(u => u[0]).sum;
    long b = used.map!(u => u[1]).sum;
    long c = used.map!(u => u[0] && u[1]).sum;
    writeln(a * b - M - c - c * (c - 1) / 2);
}
