import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long MOD = 10^^9 + 7;
immutable long INF = 1L << 59;

void main() {
    auto N = readln.chomp.to!long;

    auto dp = new long[](500);
    fill(dp, INF);
    dp[0] = 0;

    foreach (i; [1, 5, 10, 50, 100]) {
        foreach (j; 0..500) {
            if (j + i >= 500) break;
            dp[j + i] = min(dp[j + i], dp[j] + 1);
        }
    }

    dp.map!(a => a <= N).sum.writeln;
}
