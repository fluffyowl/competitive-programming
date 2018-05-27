import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto N = readln.chomp.to!int;
    auto E = new Tuple!(int, int)[](N-1);
    auto G = new Tuple!(int, int)[][](N);
    foreach (i; 0..N-1) {
        auto s = readln.split.map!(to!int);
        G[s[0]-1] ~= tuple(s[1]-1, i);
        G[s[1]-1] ~= tuple(s[0]-1, i);
        E[i] = tuple(s[0]-1, s[1]-1);
    }
    auto S = readln.split.map!(to!long).array;

    if (N == 2) {
        writeln(S[0]);
        return;
    }
    
    auto depth = new int[](N);
    auto sub = new int[](N);
    auto ans = new long[](N-1);
    
    int dfs(int n, int p, int d) {
        depth[n] = d;
        foreach (m; G[n]) if (m[0] != p) sub[n] += dfs(m[0], n, d+1);
        return sub[n] + 1;
    }
    dfs(0, -1, 0);

    long dfs2(int n, int p, long d) {
        long ret = d;
        foreach (m; G[n]) if (m[0] != p) ret += dfs2(m[0], n, d+ans[m[1]]);
        return ret;
    }

    foreach (i, e; E.enumerate) {
        int a = e[0];
        int b = e[1];
        if (S[a] == S[b]) continue; 
        if (depth[a] > depth[b]) swap(a, b);
        long aa = sub[b];
        long bb = N - sub[b] - 2;
        ans[i] = (S[a] - S[b]) / (aa - bb);
    }

    foreach (i, e; E.enumerate) {
        int a = e[0];
        int b = e[1];
        if (S[a] != S[b]) continue;
        if (depth[a] > depth[b]) swap(a, b);
        long aa = dfs2(a, b, 0);
        long bb = dfs2(b, a, 0);
        long ss = aa + bb;
        ans[i] = (S[a] - ss) / (sub[b] + 1);
    }

    ans.each!writeln;
}
