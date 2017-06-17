import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;



void main() {
    auto N = readln.chomp.to!int;
    auto F = N.iota.map!(_ => readln.split.map!(to!int).array).array;

    auto dp = new int[](1 << N);
    fill(dp, -1);
    dp[0] = 0;

    for (int mask = 0; mask < (1 << N); mask++) {
        if (dp[mask] < 0) continue;
        int i = bsf(~mask);
        foreach (j; i+1..N) {
            if (!(mask & (1 << j))) {
                dp[mask | (1 << i) | (1 << j)] = max(dp[mask | (1 << i) | (1 << j)],
                                                     dp[mask] + F[i][j]);
            }
        }
    }

    dp[(1 << N) - 1].writeln;
}

