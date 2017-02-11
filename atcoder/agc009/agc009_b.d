import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio, std.bitmanip;

int N;
int[][] adj;

long dfs(int n) {
    if (adj[n].length == 0)
        return 0;

    auto rets = new long[](adj[n].length);
    foreach (i, m; enumerate(adj[n]))
        rets[i] = dfs(m);
    rets.sort!"a > b"();
    foreach (i; 0..adj[n].length) {
        rets[i] += i + 1;
    }

    return rets.reduce!(max);
}

void main() {
    N = readln.chomp.to!int;
    adj = new int[][](N+1);
    foreach (i; 2..N+1) {
        auto n = readln.chomp.to!int;
        adj[n] ~= i;
    }

    dfs(1).writeln;
}
