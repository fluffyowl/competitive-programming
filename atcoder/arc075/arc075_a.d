import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto N = readln.chomp.to!int;
    auto A = N.iota.map!(_ => readln.chomp.to!int).array;

    auto dp = new bool[][](N+1, 10001);
    dp[0][0] = true;

    foreach (i; 0..N) {
        foreach (j; 0..10001) {
            if (dp[i][j]) {
                dp[i+1][j] = true;
                if (j + A[i] <= 10000) {
                    dp[i+1][j+A[i]] = true;
                }
            }
        }
    }


    int ans = 0;
    foreach (i; 0..10001) {
        if (i % 10 > 0 && dp[N][i])
            ans = i;
    }

    ans.writeln;
}
