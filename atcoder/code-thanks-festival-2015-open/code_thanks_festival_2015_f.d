import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;


void main() {
    auto N = readln.chomp.to!int;
    auto edges = new int[][](N);
    foreach (i; 0..N-1) {
        auto s = readln.split.map!(to!int);
        edges[s[0]-1] ~= s[1]-1;
        edges[s[1]-1] ~= s[0]-1;
    }


    int cnt = 0;
    void dfs(int n, int prev, int d) {
        if (d >= 1) cnt += 1;
        foreach (m; edges[n]) if (m != prev) dfs(m, n, d+1);
    }

    dfs(0, -1, 0);
    writeln(cnt % 2 || edges[0].length == 1 ? "A" : "B");
}
