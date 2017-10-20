import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto N = readln.chomp.to!int;
    N = min(10000, N);
    auto dp = new real[][](N + 1, 1 << 6);
    foreach (i; 0..N+1) fill(dp[i], 0);
    dp[0][0] = 1;

    foreach (i; 0..N)
        foreach (j; 0..64)
            foreach (k; 0..6)
                dp[i+1][j | (1 << k)] += dp[i][j] / 6;

    writefln("%.9f", dp[N][(1 << 6) - 1]);
}

