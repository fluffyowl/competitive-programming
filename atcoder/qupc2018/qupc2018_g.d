import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long INF = 1L << 59;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto X = s[1];
    auto Y = s[2];
    auto G = new Tuple!(int, long)[][](N);
    foreach (_; 0..N-1) {
        s = readln.split.map!(to!int);
        G[s[0]-1] ~= tuple(s[1]-1, s[2].to!long);
        G[s[1]-1] ~= tuple(s[0]-1, s[2].to!long);
    }
    auto P = readln.split.map!(i => i.to!int - 1).array;
    auto Q = readln.split.map!(i => i.to!int - 1).array;

    auto A = new int[](N);
    fill(A, 2);
    foreach (p; P) A[p] = 0;
    foreach (q; Q) A[q] = 1;

    auto dp = new long[][](N, 3);


    void dfs(int n, int p) {
        if (A[n] == 0) {
            dp[n][1] = INF;
            dp[n][2] = INF;
        } else if (A[n] == 1) {
            dp[n][0] = INF;
            dp[n][2] = INF;
        }

        foreach (to; G[n]) {
            int m = to[0];
            long c = to[1];
            if (m == p) continue;
            dfs(m, n);
            if (A[n] == 0) {
                dp[n][0] += min(dp[m][0], dp[m][1] + c, dp[m][2]);
            } else if (A[n] == 1) {
                dp[n][1] += min(dp[m][0] + c, dp[m][1], dp[m][2]);
            } else {
                dp[n][0] += min(dp[m][0], dp[m][1] + c, dp[m][2]);
                dp[n][1] += min(dp[m][0] + c, dp[m][1], dp[m][2]);
                dp[n][2] += min(dp[m][0] + c, dp[m][1] + c, dp[m][2]);
            }
        }
    }


    dfs(0, -1);
    dp[0].reduce!min.writeln;
}
