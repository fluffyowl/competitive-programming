import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

immutable long INF = 1L << 60;

void main() {
    auto s = readln.split;
    auto N = s[0].to!int;
    auto P = s[1].to!long;
    auto H = readln.split.map!(to!long).array;

    auto dp = new long[][](2, N);
    dp[0][0] = 0;
    dp[1][0] = INF;

    foreach (i; 1..N) {
        dp[0][i] = min(dp[0][i-1] + max(0, H[i]-H[i-1]),
                       min(dp[0][i-1], dp[1][i-1]) + P);
        dp[1][i] = min(dp[1][i-1] + max(0, H[i-1]-H[i]),
                       min(dp[0][i-1], dp[1][i-1]) + P);
    }

    min(dp[0][N-1], dp[1][N-1]).writeln;
}

