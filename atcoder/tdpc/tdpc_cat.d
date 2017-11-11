import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto N = readln.chomp.to!int;
    auto A = N.iota.map!(_ => readln.split.map!(to!long).array).array;
    auto B = new long[][](N + 1, N + 1);
    foreach (i; 0..N) foreach (j; iota(i, -1, -1)) B[i][j] += B[i][j+1] + A[i][j];
    auto dp = new long[][](N + 1, N + 1);

    foreach (i; 0..N) {
        dp[i+1][i+1] = - (1L << 59);
        foreach (j; 0..i+1) {
            dp[i+1][i+1] = max(dp[i+1][i+1], dp[i][j]);
            dp[i+1][j] = dp[i+1][i+1] + B[i+1][j] * 2;
        }
    }

    dp[N].reduce!max.writeln;
}
