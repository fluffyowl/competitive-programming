import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long MOD = 10^^9 + 7;

void main() {
    auto L = readln.chomp.to!int;
    auto dp = new long[][](L+1, 10);
    dp[0][0] = 1;

    foreach (i; 0..L) {
        foreach (j; 0..10) {
            foreach (k; j..10) {
                (dp[i+1][k] += dp[i][j]) %= MOD;
            }
        }
    }

    long ans = 0;
    foreach (i; 0..10) (ans += dp[L][i]) %= MOD;

    ans.writeln;
}

