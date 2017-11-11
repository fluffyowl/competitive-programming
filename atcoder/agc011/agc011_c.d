import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0].to!int;
    auto M = s[1];
    auto edges = new int[][](N);
    foreach (_; 0..M) {
        s = readln.split.map!(to!int);
        edges[s[0]-1] ~= s[1]-1;
        edges[s[1]-1] ~= s[0]-1;
    }


    int[][] groups;
    bool[] used = new bool[](N);
    int[] color = new int[](N);
    color.fill(-1);

    void dfs1(int n, int g) {
        if (used[n]) return;
        used[n] = true;
        groups[g] ~= n;
        foreach (m; edges[n]) if (used[n]) dfs1(m, g);
    }

    bool dfs2(int n, int c) {
        if (color[n] != -1) return color[n] == c;
        color[n] = c;
        foreach (m; edges[n]) {
            if (!dfs2(m, c^1)) return false;
        }
        return true;
    }


    int gn = 0;
    bool[] is_bi;
    foreach (i; 0..N) if (!used[i]) {groups ~= (new int[](0)); dfs1(i, gn++);}
    foreach (g; 0..gn) is_bi ~= dfs2(groups[g][0], g);

    long ans = 0;

    long G = groups.length;
    long one = groups.map!(g => g.length == 1).sum;
    long bi = is_bi.sum - one;
    long other = G - one - bi;

    ans += one * 2 * N - one * one;
    ans += bi * 2 + other;
    ans += bi * (bi - 1) * 2;
    ans += other * (other - 1);
    ans += other * bi * 2;

    ans.writeln;
}
