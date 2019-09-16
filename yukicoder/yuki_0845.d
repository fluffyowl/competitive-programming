import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto A = new long[][](N, N);
    foreach (_; 0..M) {
        s = readln.split.map!(to!int);
        A[s[0]-1][s[1]-1] = max(A[s[0]-1][s[1]-1], s[2]);
        A[s[1]-1][s[0]-1] = max(A[s[0]-1][s[1]-1], s[2]);
    }

    auto dp = new long[][](1<<N, N);
    foreach (mask; 0..(1 << N)) foreach (i; 0..N) if (mask & (1 << i)) foreach (j; 0..N) if (!(mask & (1 << j))) if (A[i][j]) {
        dp[mask | (1 << j)][j] = max(dp[mask | (1 << j)][j], dp[mask][i] + A[i][j]);
    }

    long ans = 0;
    foreach (i; 0..1<<N) foreach (j; 0..N) ans = max(ans, dp[i][j]);
    ans.writeln;
}

