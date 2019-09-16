import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;

void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!long).array;
    A.sort();

    auto dp = new long[][](N+1, 3); // down, stay, up
    foreach (i; 0..N+1) foreach (j; 0..3) dp[i][j] = 1L << 59;
    dp[0][0] = 0;

    foreach (i; 0..N) {
        if (i != 0) {
            dp[i+1][0] = min(dp[i+1][0], dp[i][1] + A[i] - A[i-1]);
        }
        dp[i+1][1] = min(dp[i+1][1], dp[i][2]);
        if (i != N - 1) {
            dp[i+1][2] = min(dp[i+1][2], min(dp[i][0], dp[i][1]) + A[i+1] - A[i]);
        }
    }

    dp[N].reduce!min.writeln;
}


