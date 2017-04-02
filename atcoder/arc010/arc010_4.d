import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.exception;
     
     
struct Point {
    long x;
    long y;
     
    long dist(Point other) {
        return (this.x-other.x)^^2 + (this.y-other.y)^^2;
    }
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
     
     
void main() {
    auto N = readln.chomp.to!int;
    auto P = new Point[](N);
    foreach (i; 0..N) {
        auto s = readln.split.map!(to!long);
        P[i] = Point(s[0], s[1]);
    }
     
    auto M = readln.chomp.to!int;
    auto S = new Point[](M);
    foreach (i; 0..M) {
        auto s = readln.split.map!(to!long);
        S[i] = Point(s[0], s[1]);
    }
     
        
    auto scc = new Kosaraju(N);
        
    foreach (i; 0..N) {
        auto spy_dist = 1L << 60;
        foreach (j; 0..M) spy_dist = min(spy_dist, P[i].dist(S[j]));
        foreach (j; 0..N) {
            if (i != j && P[i].dist(P[j]) < spy_dist) {
                scc.add_edge(i, j);
            }
        }
    }
     
    scc.run;
    int ans = 0;
     
    foreach (g; scc.group_adj_rev) {
        if (g.length == 0) ans += 1;
    }
     
    writeln(ans);
     
}
