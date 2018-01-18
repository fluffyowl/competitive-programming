import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

immutable long MOD = 10^^9+7;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto K = s[1];
    auto dp = new long[][](N+1, N*N);
    dp[1][0] = 1;

    foreach (i; 1..N) {
        foreach (j; 0..N*N-1) {
            if (dp[i][j] == 0) continue;
            dp[i+1][j] += dp[i][j];
            dp[i+1][j] %= MOD;
            dp[i+1][j+i+1] -= dp[i][j];
            dp[i+1][j+i+1] %= MOD;
        }
        foreach (j; 0..N*N-1) {
            dp[i+1][j+1] += dp[i+1][j];
            dp[i+1][j+1] %= MOD;
        }
    }

    long ans = 0;
    foreach (j; 0..K+1) (ans += dp[N][j]) %= MOD;
    ans = (ans + MOD) % MOD;
    ans.writeln;
}

