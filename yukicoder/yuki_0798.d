import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;

void main() {
    auto N = readln.chomp.to!int;
    auto AB = N.iota.map!(_ => readln.split.map!(to!long).array).array;
    AB.sort!"a[1] > b[1]";

    int buy = N - N / 3;

    auto dp = new long[][](N+1, buy+1);
    foreach (i; 0..N+1) dp[i][] = 1L << 59;
    dp[0][0] = 0;

    foreach (i; 0..N) {
        foreach (j; 0..buy+1) {
            if (j < buy) {
                dp[i+1][j+1] = min(dp[i+1][j+1], dp[i][j] + AB[i][0] + AB[i][1] * j);
            }
            dp[i+1][j] = min(dp[i+1][j], dp[i][j]);
        }
    }

    dp[N][buy].writeln;
}

