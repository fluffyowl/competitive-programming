import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

immutable long MOD = 10^^9 + 7;

void main() {
    auto N = readln.chomp.to!int;
    auto dp = new long[][](N+1, 4);
    dp[0][0] = 1;

    foreach (i; 1..N+1) {
        foreach (j; 0..4) {
            foreach (k; 0..4) {
                if (k == 0) continue;
                if (j == k) continue;
                if (i-k < 0) continue;
                (dp[i][k] += dp[i-k][j]) %= MOD;
            }
        }
    }

    writeln((dp[N][1] + dp[N][2] + dp[N][3]) % MOD);
}

