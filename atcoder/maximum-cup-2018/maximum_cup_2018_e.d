import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto Q = readln.chomp.to!int;
    auto G = new int[][](Q);
    Tuple!(int, int)[] B;

    foreach (_; 0..Q) {
        auto s = readln.split;
        auto i = s[1].to!int - 1;
        auto j = s[2].to!int - 1;
        if (s[0] == "A") G[i] ~= j, G[j] ~= i;
        else B ~= tuple(i, j);
    }



    auto depth = new int[](Q);
    auto dp = new int[][](20, Q);

    void dfs(int n, int p, int d) {
        dp[0][n] = p;
        depth[n] = d;
        foreach (m; G[n]) if (m != p) dfs(m, n, d+1);
    }

    dfs(0, -1, 0);

    foreach (k; 0..19)
        foreach (n; 0..Q)
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

    foreach (n; B) {
        int a = n[0];
        int b = n[1];
        int c = lca(a, b);
        writeln(depth[a] + depth[b] - depth[c]*2 - 1);
    }
}
