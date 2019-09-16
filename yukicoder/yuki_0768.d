import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;

void main() {
    auto N = readln.chomp.to!int;
    auto G = new int[][](N);
    foreach (_; 0..N-1) {
        auto s = readln.split.map!(to!int);
        G[s[0]-1] ~= s[1]-1;
        G[s[1]-1] ~= s[0]-1;
    }
    auto f = new bool[](N);
    auto g = new bool[](N);
    auto cnt = new int[](N);


    void dfs1(int n, int p) {
        f[n] = true;
        if (p != -1 && G[n].length == 1) {
            return;
        }
        foreach (m; G[n]) {
            if (m == p) continue;
            dfs1(m, n);
            if (f[m]) f[n] = false, cnt[n] += 1;
        }
    }

    void dfs2(int n, int p) {
        if (p == -1) {
            g[n] = f[n];
            foreach (m; G[n]) dfs2(m, n);
            return;
        }

        bool fp = g[p];
        if (!g[p] && f[n] && cnt[p] == 1) {
            fp = true;
        }
        if (fp) {
            cnt[n] += 1;
        }
        g[n] = cnt[n] == 0;

        foreach (m; G[n]) if (m != p) dfs2(m, n);
    }

    dfs1(0, -1);
    dfs2(0, -1);

    g.sum.writeln;
    N.iota.filter!(i => g[i]).each!(i => writeln(i+1));
}

