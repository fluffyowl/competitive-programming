import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;
 
void main() {
    auto N = readln.chomp.to!int;
    auto edges = new int[][](N);
    foreach (_; 0..N-1) {
        auto s = readln.split.map!(to!int);
        edges[s[0] - 1] ~= s[1] - 1;
        edges[s[1] - 1] ~= s[0] - 1;
    }

    int dfs(int n, int p) {
        int ret = 0;
        foreach (m; edges[n]) if (m != p) ret ^= (dfs(m, n) + 1);
        return ret;
    }

    writeln( dfs(0, -1) ? "Alice" : "Bob" );
}
