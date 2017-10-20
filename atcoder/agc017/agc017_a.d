import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto P = s[1];
    auto A = readln.split.map!(to!int).array;

    auto dp = new long[][](N+1, 2);
    dp[0][0] = 1;

    foreach (i; 0..N) {
        if (A[i] % 2 == 0) {
            dp[i+1][0] = dp[i][0] + dp[i][0];
            dp[i+1][1] = dp[i][1] + dp[i][1];
        }
        else {
            dp[i+1][0] = dp[i][0] + dp[i][1];
            dp[i+1][1] = dp[i][0] + dp[i][1];
        }
    }

    dp[N][P].writeln;
}
