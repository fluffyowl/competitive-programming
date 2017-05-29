import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;


void main() {
    immutable long MOD = 10^^9 + 7;
    
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto K = s[1];
    auto edges = new int[][](N);
    foreach (i; 0..N-1) {
        s = readln.split.map!(to!int);
        edges[s[0]] ~= s[1];
        edges[s[1]] ~= s[0];
    }

    if (K == 0) {
        writeln(1);
        return;
    }


    auto children = new int[](N);
    auto dp = new long[][](N, N+2);
    foreach (i; 0..N) fill(dp[i], 0);
    auto tmp = new long[](N+1);

    int dfs1(int n, int prev) {
        children[n] = 1;
        foreach (m; edges[n]) if (m != prev) children[n] += dfs1(m, n);
        return children[n];
    }
    
    void dfs2(int n, int prev) {
        foreach (m; edges[n]) if (m != prev) dfs2(m, n);

        dp[n][children[n]] = 1;
        if (children[n] == 1) return;
        
        foreach (m; edges[n]) {
            if (m == prev) continue;
            fill(tmp, 0);
            foreach (i; 0..children[n]) {
                if (dp[n][i] == 0) continue;
                foreach (j; 0..children[m]+1) {
                    if (i + j > children[n]) break;
                    tmp[i+j] += (dp[n][i] * dp[m][j]) % MOD;
                    tmp[i+j] %= MOD;
                }
            }

            foreach (i; 0..children[n]+1) (dp[n][i] += tmp[i]) %= MOD;
            foreach (i; 0..children[m]+1) (dp[n][i] += dp[m][i]) %= MOD;
        }

    }

    dfs1(0, -1);
    dfs2(0, -1);
    //dp.each!writeln;
    dp[0][K].writeln;
}

