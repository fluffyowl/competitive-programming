import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable int INF = 1 << 29;

void main() {
    auto s = readln.split.map!(to!int);
    auto D = s[0];
    auto N = s[1];
    auto T = D.iota.map!(_ => readln.chomp.to!int).array;
    auto A = N.iota.map!(_ => readln.split.map!(to!int).array).array;
    auto dp = new int[][](D, N);
    foreach (i; 0..D) fill(dp[i], -INF);
    foreach (i; 0..N) dp[0][i] = (A[i][0] <= T[0] && T[0] <= A[i][1]) ? 0 : -INF;

    foreach (i; 1..D) {
        foreach (j; 0..N) {
            if (A[j][0] > T[i] || A[j][1] < T[i]) {
                dp[i][j] = -INF;
                continue;
            }
            foreach (k; 0..N) {
                dp[i][j] = max(dp[i][j], dp[i-1][k] + abs(A[j][2] - A[k][2]));
            }
        }
    }

    dp[D-1].reduce!max.writeln;
}
