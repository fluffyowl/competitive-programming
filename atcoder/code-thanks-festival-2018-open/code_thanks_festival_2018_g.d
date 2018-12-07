import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip, core.stdc.string;

immutable long MOD = 10^^9 + 7;
immutable int MAX = 1000;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto K = s[1];
    auto A = readln.split.map!(i => i.to!int-1).array;
    auto B = readln.split.map!(i => i.to!int-1).array;

    auto AB = N.iota.map!(i => tuple(A[i], B[i])).array;
    AB.sort();
    auto used = new bool[](N);

    int[] group(int n) {
        int[] ret = [n];
        while (AB[ret.back][1] != AB[n][0]) {
            ret ~= AB[ret.back][1];
        }
        foreach (x; ret) {
            used[x] = true;
        }
        return ret;
    }

    int[][] G;
    foreach (i; 0..N) if (!used[i]) G ~= group(i).dup;

    int M = G.length.to!int;
    auto dp = new int[][][][](2, N+2, 2, 2);
    foreach (i; 0..2) foreach (j; 0..N+2) foreach (x; 0..2) foreach (y; 0..2) dp[i][j][x][y] = -(1 << 29);
    dp[0][0][0][0] = 0;
    int cur = 0;
    int tar = 1;

    for (int i = 0; i < M; ++i) {
        int n = G[i].length.to!int;
        for (int j = 0; j < n; ++j) {
            foreach (k; 0..N+2) foreach (x; 0..2) foreach (y; 0..2) dp[tar][k][x][y] = - (1 << 29);
            int a = AB[G[i][j]][0] + 1;
            int b = AB[G[i][j]][1] + 1;
            for (int k = 0; k < N + 1; ++k) {
                for (int x = 0; x < 2; ++x) {
                    if (j == 0) {
                        int v = max(dp[cur][k][0][0], dp[cur][k][0][1], dp[cur][k][1][0], dp[cur][k][1][1]);
                        if (x == 0) dp[tar][k+1][0][0] = max(dp[tar][k+1][0][0], v + a);
                        if (x == 1) dp[tar][k+1][1][1] = max(dp[tar][k+1][1][1], v + b);
                    } else if (j == n - 1) {
                        if (x == 0) {
                            dp[tar][k][x][0] = max(dp[tar][k][x][0], dp[cur][k][x][1] + a);
                            dp[tar][k][x][1] = max(dp[tar][k][x][1], dp[cur][k][x][0] + b, dp[cur][k][x][1] + b);
                            dp[tar][k+1][x][0] = max(dp[tar][k+1][x][0], dp[cur][k][x][0] + a);
                        } else {
                            dp[tar][k][x][0] = max(dp[tar][k][x][0], dp[cur][k][x][1] + a);
                            dp[tar][k+1][x][0] = max(dp[tar][k+1][x][0], dp[cur][k][x][0] + a);
                            dp[tar][k+1][x][1] = max(dp[tar][k+1][x][1], dp[cur][k][x][0] + b, dp[cur][k][x][1] + b);
                        }
                    } else {
                        dp[tar][k][x][0] = max(dp[tar][k][x][0], dp[cur][k][x][1] + a);
                        dp[tar][k+1][x][0] = max(dp[tar][k+1][x][0], dp[cur][k][x][0] + a);
                        dp[tar][k+1][x][1] = max(dp[tar][k+1][x][1], dp[cur][k][x][0] + b, dp[cur][k][x][1] + b);
                    }
                }
            }
            cur ^= 1;
            tar ^= 1;
        }
    }


    int ans = 0;
    foreach (j; K..N+1) ans = max(ans, dp[cur][j][0][0], dp[cur][j][0][1], dp[cur][j][1][0], dp[cur][j][1][1]);
    ans.writeln;
}
