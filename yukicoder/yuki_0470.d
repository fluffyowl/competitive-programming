import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

class Kosaraju {
    int N;
    int[][] adj;
    int[][] rev_adj;
    int[] group;
    bool[] group_prev;
    int[][] group_n;

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
        foreach (i; iota(N-1, -1, -1))
            if (!used[ord[i]]) {
                dfs2(ord[i], g_num, used);
                g_num += 1;
            }
        group_n = new int[][](group.reduce!(max)+1);
        foreach (i; 0..N)
            group_n[group[i]] ~= i;
        group_prev = new bool[](group.reduce!(max)+1);
        foreach (i; 0..N)
            foreach (j; adj[i])
                if (group[i] != group[j])
                    group_prev[group[j]] = true;
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

void main() {
    auto N = readln.chomp.to!int;
        
    if (N > 52) {
        writeln("Impossible");
        return;
    }

    auto U = N.iota.map!(_ => readln.chomp).array;
    auto G = new Kosaraju(2*N);
    
    foreach (i; 0..N) {
        foreach (j; i+1..N) {
            // (xi => not xj) & (xj => not xi)
            if (U[i][0] == U[j][0] || U[i][1..3] == U[j][1..3])
                G.add_edge(i, j+N), G.add_edge(j, i+N);
            // (xi => xj) & (not xj => not xi)
            if (U[i][0] == U[j][2] || U[i][1..3] == U[j][0..2])
                G.add_edge(i, j), G.add_edge(j+N, i+N);
            // (not xi => not xj) & (xj => xi)
            if (U[i][2] == U[j][0] || U[i][0..2] == U[j][1..3])
                G.add_edge(i+N, j+N), G.add_edge(j, i);
            // (not xi => xj) & (not xj => xi)
            if (U[i][2] == U[j][2] || U[i][0..2] == U[j][0..2])
                G.add_edge(i+N, j), G.add_edge(j+N, i);
        }
    }

    G.run;

    auto div = new bool[](N);
    foreach (i; 0..N) {
        if (G.group[i] == G.group[i+N]) {
            writeln("Impossible");
            return;
        }
        else if (G.group[i] > G.group[i+N]) {
            div[i] = true;
        }
    }

    foreach (i; 0..N) {
        if (div[i]) writeln(U[i][0], " ", U[i][1..3]);
        else        writeln(U[i][0..2], " ", U[i][2]);
    }
}

