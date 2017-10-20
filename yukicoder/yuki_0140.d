import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;

immutable long MOD = 10^^9 + 7;
long dp[2][560][1150];

void main() {
    auto N = readln.chomp.to!int;
    //auto dp = new long[][][](2, N+5, 2*N+5);
    memset(dp[0].ptr, 0, dp[0].sizeof);
    dp[0][0][0] = 1;
    
    //foreach (i; 0..N) {
    for (int i = 0; i < N; ++i) {
        int cur = i & 1;
        int tar = cur ^ 1;
        memset(dp[tar].ptr, 0, dp[tar].sizeof);
        //foreach (j; 0..N+1) if (j < i + 1) foreach (k; 0..2*N+1) {
        for (int j = 0; j < i + 1; ++j) for (int k = 0; j + k <= i * 2; ++k) {
            dp[tar][j][k+2] += dp[cur][j][k];
            dp[tar][j][k+1] += dp[cur][j][k] * 2 * (j+k);
            dp[tar][j][k]   += dp[cur][j][k] * ((j+k) * (j+k) - k);
            dp[tar][j+1][k] += dp[cur][j][k];
            if (k > 0) dp[tar][j+1][k-1] += dp[cur][j][k] * k;
        }
        for (int j = 0; j < i + 2; ++j) for (int k = 0; j + k <= (i + 1) * 2; ++k) {
            dp[tar][j][k] %= MOD;
        }
    }

    long ans = 0;
    foreach (i; 1..N+1) (ans += dp[N % 2][i][0]) %= MOD;
    ans.writeln;
}

