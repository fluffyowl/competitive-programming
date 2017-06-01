import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

immutable long INF = 1L << 58;

void main() {
    auto N = readln.chomp.to!int;
    auto S = N.iota.map!(_ => readln.chomp.to!long).array;
    auto edges = new int[][](N);
    foreach (i; 0..N-1) {
        auto s = readln.split.map!(to!int);
        edges[s[0] - 1] ~= s[1] - 1;
        edges[s[1] - 1] ~= s[0] - 1;
    }
    auto M = readln.chomp.to!int;
    auto T = M.iota.map!(_ => readln.chomp.to!long).array;
    T.sort!"a > b"();


    auto dp  = new long[][](N, M + 1);
    auto tmp = new long[][](2, M + 1);

    foreach (i; 0..N)
        foreach (j; 0..M+1)
            dp[i][j] = j == 0 ? 0 : INF;


    void dfs(int n, int prev) {
        foreach (m; edges[n])
            if (m != prev)
                dfs(m, n);

        foreach (i; 0..2)
            foreach (j; 0..M+1)
                tmp[i][j] = j == 0 ? 0 : INF;

        foreach (i; 0..edges[n].length) {
            int cur = i % 2;
            int tar = 1 - cur;
            int m = edges[n][i];
            foreach (j; 0..M+1) {
                if (tmp[cur][j] == INF)
                    break;
                foreach (k; 0..M-j+1) {
                    if (dp[m][k] == INF)
                        break;
                    tmp[tar][j+k] = min(tmp[tar][j+k], tmp[cur][j] + dp[m][k]);
                }
            }
        }

        foreach (i; 0..M)
            dp[n][i+1] = tmp[edges[n].length%2][i] + S[n];
                
    }

    dfs(0, -1);
    long ans = 0;
    long ss = S.sum;
    long ts = 0;
    foreach (i; 0..M+1) {
        ans = max(ans, ss - dp[0][i] + ts);
        if (i < M)
            ts += T[i];
    }
    ans.writeln;
}
