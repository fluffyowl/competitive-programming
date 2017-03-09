import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio, std.bitmanip;


void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.chomp.to!int;
    auto AA = new Tuple!(int, int)[](A);
    foreach (i; 0..A) {
        auto s = readln.split.map!(to!int);
        AA[i] = tuple(s[1]-1, s[0]-1);
    }
    auto B = readln.chomp.to!int;
    auto BB = new Tuple!(int, int)[](B);
    foreach (i; 0..B) {
        auto s = readln.split.map!(to!int);
        BB[i] = tuple(s[0]-1, s[1]-1);
    }


    int ans = 0;
    foreach (i; 0..2^^B) {
        auto scc = new Kosaraju(N);
        auto not_paint = new bool[](N);
        foreach (j; 0..A) {
            scc.add_edge(AA[j][0], AA[j][1]);
        }
        foreach (j; 0..B) {
            if (i & (1 << j)) {
                scc.add_edge(BB[j][0], BB[j][1]);
            }
            else {
                not_paint[BB[j][0]] = true;
            }
        }

        scc.run;
        int tmp = 0;
        auto painted = new bool[](scc.g);
        foreach (j; 0..scc.g) {
            if (scc.group_adj_rev[j].map!(x => painted[x]).all &&
                scc.group_n[j].length == 1 &&
                !not_paint[scc.group_n[j][0]]) {
                painted[j] = true;
                tmp += 1;
            }
        }

        ans = max(ans, tmp);
    }

    ans.writeln;
}


class Kosaraju {
    int N;
    int[][] adj;
    int[][] rev_adj;
    int g;
    int[] group;
    int[][] group_n;
    int[][] group_adj;
    int[][] group_adj_rev;
    string[][] group_s;

    this(int n) {
        N = n;
        adj = new int[][](N);
        rev_adj = new int[][](N);
        group = new int[](N);
    }

    void add_edge(int from, int to) {
        adj[from] ~= to;
        rev_adj[to] ~= from;
    }

    void run() {
        int[] ord;
        auto used = new bool[](N);
        foreach (i; 0..N)
            if (!used[i])
                dfs1(i, ord, used);
        foreach (i; 0..N) used[i] = false;
        auto g_num = 0;
        foreach (i; iota(N-1, -1, -1)) {
            if (!used[ord[i]]) {
                dfs2(ord[i], g_num, used);
                g_num += 1;
            }
        }

        g = group.reduce!(max)+1;
        group_n = new int[][](g);
        foreach (i; 0..N)
            group_n[group[i]] ~= i;

        group_adj = new int[][](g);
        group_adj_rev = new int[][](g);
        foreach (i; 0..N)
            foreach (j; adj[i])
                if (group[i] != group[j])
                    group_adj_rev[group[j]] ~= group[i];
        foreach (i; 0..g) {
            group_adj_rev[i] = group_adj_rev[i].sort().uniq.array;
        }

    }

    void dfs1(int from, ref int[] ord, ref bool[] used) {
        if (used[from]) return;
        used[from] = true;
        foreach (to; adj[from])
            if (!used[to])
                dfs1(to, ord, used);
        ord ~= from;
    }

    void dfs2(int from, int g_num, ref bool[] used) {
        if (used[from]) return;
        used[from] = true;
        group[from] = g_num;
        foreach (to; rev_adj[from])
            if (!used[to])
                dfs2(to, g_num, used);
    }


}
