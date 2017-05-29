import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;


void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!long);
    auto dp = new long[long][](N);
    dp[0][A[0]] = true;
    foreach (i; 0..N-1) {
        foreach (j; dp[i].keys) {
            dp[i+1][j+A[i+1]] = true;
            dp[i+1][j-A[i+1]] = true;
            dp[i+1][j*A[i+1]] = true;
            if (A[i+1] != 0) dp[i+1][j/A[i+1]] = true;
        }
    }

    writeln(dp[N-1].keys.reduce!max);
}

