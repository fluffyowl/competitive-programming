import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

void solve() {
    auto n = readln.split.map!(to!int).array.sort();
    auto m = readln.chomp.to!int;
    auto A = readln.split.map!(to!int).array.sort();
    auto acm = new int[](m);
    acm[0] = A[0];
    foreach (i; 1..m) acm[i] = acm[i-1] + A[i];

    auto dp = new int[][](m, n[0]+1);
    if (A[0] <= n[0]) dp[0][n[0]-A[0]] = 1;
    if (A[0] <= n[1]) dp[0][n[0]] = 1;

    foreach (i; 1..m) {
        foreach (j; 0..n[0]+1) { // j = 1本目の竹の残り
            int k = n[1] - (acm[i-1] - (n[0] - j)); // k = 2本目の竹の残り
            if (A[i] <= j) dp[i][j-A[i]] = max(dp[i][j-A[i]], dp[i-1][j] + 1);
            if (A[i] <= k) dp[i][j] = max(dp[i][j], dp[i-1][j] + 1);
        }
    }

    dp.map!(x => x.reduce!(max)).reduce!(max).writeln;
}

void main() {
    auto d = readln.chomp.to!int;
    foreach (i; 0..d)
        solve;
}

