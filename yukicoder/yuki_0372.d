import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;

immutable int MOD = 10^^9+7;

void main() {
    auto S = readln.chomp;
    auto N = S.length;
    auto M = readln.chomp.to!int;

    int[20000][2] dp;
    dp[0][0] = 0;

    foreach (i; 0..N) {
        int cur = i % 2;
        int tar = 1 ^ cur;
        int n = S[i] - '0';
        memcpy(dp[tar].ptr, dp[cur].ptr, dp[cur].sizeof);
        foreach (j; 0..M) {
            dp[tar][(10*j+n)%M] += dp[cur][j];
            dp[tar][(10*j+n)%M] %= MOD;
        }
        if (n != 0) {
            dp[tar][n%M] += 1;
            dp[tar][n%M] %= MOD;
        }
    }

    int ans = S.count('0').to!int + dp[N%2][0];
    ans %= MOD;
    ans.writeln;
}

