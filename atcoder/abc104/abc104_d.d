import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long MOD = 10^^9 + 7;

void main() {
    auto S = readln.chomp;
    auto N = S.length.to!int;
    auto dp = new long[][](N+1, 4); // Aの数, ABの数, ABCの数
    dp[0][0] = 1;

    foreach (i; 0..N) {
        foreach (j; 0..4) {
            dp[i+1][j] = S[i] == '?' ? dp[i][j] * 3 % MOD : dp[i][j];
        }
        if (S[i] == 'A' || S[i] == '?') {
            (dp[i+1][1] += dp[i][0]) %= MOD;
        }
        if (S[i] == 'B' || S[i] == '?') {
            (dp[i+1][2] += dp[i][1]) %= MOD;
        }
        if (S[i] == 'C' || S[i] == '?') {
            (dp[i+1][3] += dp[i][2]) %= MOD;
        }
    }

    dp[N][3].writeln;
}
