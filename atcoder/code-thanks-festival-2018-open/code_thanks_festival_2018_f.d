import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip, core.stdc.string;

immutable long MOD = 10^^9 + 7;
immutable int MAX = 1000;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto K = s[2];
    auto P = readln.split.map!(i => i.to!int-1).array;

    int root;
    auto G = new int[][](N);
    foreach (i; 0..N) {
        if (P[i] == -1) root = i;
        else G[P[i]] ~= i;
    }

    auto D = new int[](N);
    void depth(int n, int d) {
        D[n] = d;
        foreach (m; G[n]) depth(m, d+1);
    }
    depth(root, 1);

    int[] ans;
    int[] d_tmp;
    auto used = new bool[](N);

    void dfs(int n, int d) {
        if (used[n]) return;
        d_tmp ~= d;
        foreach (m; G[n]) if (!used[m]) dfs(m, d+1);
    }

    void dfs2(int n) {
        used[n] = true;
        foreach (m; G[n]) dfs2(m);
    }

    while (M--) {
        bool ok = false;
        foreach (i; 0..N) {
            if (used[i]) continue;
            used[i] = true;
            dfs(root, 1);
            d_tmp.sort();
            if (d_tmp.length < M) {
                d_tmp = [];
                used[i] = false;
                continue;
            }
            int mn = d_tmp[0..M].sum;
            int mx = d_tmp[$-M..$].sum;
            //writeln([M, K, i, mn, mx], " ", d_tmp);
            d_tmp = [];
            used[i] = false;
            if (mn <= K - D[i] && K - D[i] <= mx) {
                K -= D[i];
                ok = true;
                ans ~= i;
                dfs2(i);
                break;
            }
        }
        if (!ok) {
            writeln(-1);
            return;
        }
    }

    if (M != -1 || K != 0)
        writeln(-1);
    else
        ans.map!(i => i + 1).map!(to!string).join(" ").writeln;
}
