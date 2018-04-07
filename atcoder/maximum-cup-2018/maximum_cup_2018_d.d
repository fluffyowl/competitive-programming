import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto L = s[2];
    auto X = s[3];
    auto A = readln.split.map!(to!int).array;

    auto dp = new long[][](N+1, M); // 燃料iまで見たとき余りがjであるような最小の和
    foreach (i; 0..N+1) dp[i].fill(1L << 59);
    dp[0][0] = 0;

    foreach (i; 0..N) {
        foreach (j; 0..M) dp[i+1][j] = min(dp[i][j], dp[i+1][j]);
        foreach (j; 0..M) dp[i+1][(j+A[i])%M] = min(dp[i+1][(j+A[i])%M], dp[i][j] + A[i]);
    }

    writeln(dp[N][L] / M + 1 <= X ? "Yes" : "No");
}
