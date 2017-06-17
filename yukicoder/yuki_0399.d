import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

void main() {
    auto N = readln.chomp.to!int;
    auto edges = new int[][](N);
    foreach (i; 0..N-1) {
        auto s = readln.split.map!(to!int);
        edges[s[0] - 1] ~= s[1] - 1;
        edges[s[1] - 1] ~= s[0] - 1;
    }


    auto depth = new int[](N);
    auto dp = new int[][](20, N);
    
    void dfs(int n, int p, int d) {
        dp[0][n] = p;
        depth[n] = d;
        foreach (m; edges[n]) if (m != p) dfs(m, n, d+1);
    }
    
    dfs(0, -1, 0);
 
    foreach (k; 0..19)
        foreach (n; 0..N)
            dp[k+1][n] = (dp[k][n] == -1) ? -1 : dp[k][dp[k][n]];
 
    int lca(int a, int b) {
        if (depth[a] < depth[b]) swap(a, b);
        
        auto orig_a = a;
        auto orig_b = b;
        
        while (depth[a] > depth[b]) {
            int K = 19;
            foreach (k; iota(K, -1, -1)) {
                if (2^^k <= depth[a] - depth[b]) {
                    a = dp[k][a];
                    K = k;
                }
            }
        }
        
        if (a == b) return a;
        
        while (dp[0][a] != dp[0][b]) {
            int K = 19;
            foreach (k; iota(K, -1, -1)) {
                if (dp[k][a] != dp[k][b]) {
                    a = dp[k][a];
                    b = dp[k][b];
                    K = k;
                }
            }
        }
        
        return dp[0][a];
    }
  

    auto imos = new long[](N);
    fill(imos, 0);
    
    auto Q = readln.chomp.to!int;
    while (Q--) {
        auto s = readln.split.map!(to!int);
        auto a = s[0] - 1;
        auto b = s[1] - 1;
        auto c = lca(a, b);
        imos[a] += 1;
        imos[b] += 1;
        imos[c] -= 1;
        if (c > 0) imos[dp[0][c]] -= 1;
        //else imos[0] -= 1;
    }


    long dfs2(int n, int prev) {
        foreach (m; edges[n]) {
            if (m != prev) imos[n] += dfs2(m, n);
        }
        return imos[n];
    }

    dfs2(0, -1);
    imos.map!(a => a * (a + 1) / 2).sum.writeln;
}

