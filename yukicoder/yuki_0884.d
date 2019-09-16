import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

void main() {
    auto S = readln.chomp;
    auto N = S.length.to!int;

    auto dp = new int[][](N+1, 2);
    foreach (i; 0..N+1) dp[i][] = 1 << 29;
    dp[0][0] = 0;

    foreach (i; 0..N) {
        if (S[i] == '0') {
            dp[i+1][0] = min(dp[i+1][0], dp[i][0], dp[i][1] + 3);
            dp[i+1][1] = min(dp[i+1][1], dp[i][1] + 1);
        } else {
            dp[i+1][0] = min(dp[i+1][0], dp[i][0] + 1, dp[i][1] + 2);
            dp[i+1][1] = min(dp[i+1][1], dp[i][0], dp[i][1]);
        }
    }

    dp[N][0].writeln;
}

