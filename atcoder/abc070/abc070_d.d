import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

const long INF = 1L << 59;
const long MOD = 10 ^^ 9 + 7;


void main() {
    auto N = readln.chomp.to!int;
    auto edges = new Tuple!(int, long)[][](N);
    foreach (i; 0..N-1) {
        auto s = readln.split.map!(to!int);
        edges[s[0] - 1] ~= tuple(s[1] - 1, s[2].to!long);
        edges[s[1] - 1] ~= tuple(s[0] - 1, s[2].to!long);
    }
    auto dist = new long[](N);

    void dfs(int n, int p, long c) {
        dist[n] = c;
        foreach (m; edges[n]) if (m[0] != p) dfs(m[0], n, c + m[1]);
    }

    auto s = readln.split.map!(to!int);
    auto Q = s[0];
    auto K = s[1] - 1;
    dfs(K, -1, 0);
    while (Q--) {
        s = readln.split.map!(to!int);
        writeln(dist[s[0] - 1] + dist[s[1] - 1]);
    }
}
