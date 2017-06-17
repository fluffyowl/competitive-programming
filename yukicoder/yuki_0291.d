import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

void main() {
    auto S = readln.chomp;
    auto N = S.length.to!int;

    immutable int M = 21;

    auto dp = new int[][][][][](N+1, M, M, M, M);
    foreach (i; 0..N+1)
        foreach (a; 0..M)
            foreach (b; 0..M)
                foreach (c; 0..M)
                    fill(dp[i][a][b][c], -1);
    dp[0][0][0][0][0] = 0;

    foreach (i; 0..N) {
        foreach (a; 0..M) {
            foreach (b; 0..a+1) {
                foreach (c; 0..b+1) {
                    foreach (d; 0..c+1) {
                        if (dp[i][a][b][c][d] < 0) continue;
                        else if (S[i] == 'K' && a < M - 1) dp[i+1][a+1][b][c][d] = max(dp[i][a][b][c][d], dp[i+1][a+1][b][c][d]);
                        else if (S[i] == 'U' && b < M - 1) dp[i+1][a][b+1][c][d] = max(dp[i][a][b][c][d], dp[i+1][a][b+1][c][d]);
                        else if (S[i] == 'R' && c < M - 1) dp[i+1][a][b][c+1][d] = max(dp[i][a][b][c][d], dp[i+1][a][b][c+1][d]);
                        else if (S[i] == 'O' && d < M - 1) dp[i+1][a][b][c][d+1] = max(dp[i][a][b][c][d], dp[i+1][a][b][c][d+1]);
                        else if (S[i] == 'I' && min(a, b, c, d) > 0) dp[i+1][a-1][b-1][c-1][d-1] = max(dp[i][a][b][c][d] + 1, dp[i+1][a-1][b-1][c-1][d-1]);
                        else if (S[i] == '?') {
                            if (a < M - 1) dp[i+1][a+1][b][c][d] = max(dp[i][a][b][c][d], dp[i+1][a+1][b][c][d]);
                            if (b < M - 1) dp[i+1][a][b+1][c][d] = max(dp[i][a][b][c][d], dp[i+1][a][b+1][c][d]);
                            if (c < M - 1) dp[i+1][a][b][c+1][d] = max(dp[i][a][b][c][d], dp[i+1][a][b][c+1][d]);
                            if (d < M - 1) dp[i+1][a][b][c][d+1] = max(dp[i][a][b][c][d], dp[i+1][a][b][c][d+1]);
                            if (min(a, b, c, d) > 0) dp[i+1][a-1][b-1][c-1][d-1] = max(dp[i][a][b][c][d] + 1, dp[i+1][a-1][b-1][c-1][d-1]);
                        }
                        dp[i+1][a][b][c][d] = max(dp[i][a][b][c][d], dp[i+1][a][b][c][d]);
                    }
                }
            }
        }
    }

    int ans = 0;
    foreach (a; 0..M)
        foreach (b; 0..M)
            foreach (c; 0..M)
                foreach (d; 0..M)
                    ans = max(ans, dp[N][a][b][c][d]);
    ans.writeln;
}


