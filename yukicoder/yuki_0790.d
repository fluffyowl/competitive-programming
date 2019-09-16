import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;

immutable long MOD = 998244353;

void main() {
    auto N = readln.chomp.to!int;

    auto dp = new long[][](N*2+1, N+1);
    dp[0][0] = 1;

    foreach (i; 0..2*N) {
        foreach (j; 0..N+1) {
            if (j > 0) dp[i+1][j-1] += dp[i][j];
            if (j < N) dp[i+1][j+1] += dp[i][j];
        }
    }

    dp[2*N][0].writeln;
}

