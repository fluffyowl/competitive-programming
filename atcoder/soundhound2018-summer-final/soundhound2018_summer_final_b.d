import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long INF = 1L << 59;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto K = s[1];
    auto A = N.iota.map!(_ => readln.chomp.to!long).array;
    auto B = new long[](N+1);
    foreach (i; 0..N) B[i+1] = B[i] + A[i];

    auto dp = new long[][](N+1, 2);
    foreach (i; 0..N+1) fill(dp[i], -INF);
    dp[0][0] = 0;

    foreach (i; 0..N) {
        dp[i+1][0] = max(dp[i+1][0], max(dp[i][0], dp[i][1]) + A[i]);
        dp[i+1][1] = max(dp[i+1][1], dp[i][1]);
        if (i+K <= N)
            dp[i+K][1] = max(dp[i+K][1], dp[i].reduce!max);
    }

    max(dp[N][0], dp[N][1], 0).writeln;
}
