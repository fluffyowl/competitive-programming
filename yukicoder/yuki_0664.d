import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto K = s[2];
    auto A = (N+1).iota.map!(_ => readln.chomp.to!long).array;

    auto dp = new long[][](N+1, M+1);
    dp[0][0] = K;

    foreach (i; 0..N) {
        if ((i == 0 || A[i] <= A[i-1]) && A[i] <= A[i+1]) {
            foreach (j; i+1..N+1) {
                if (A[j] >= A[j-1] && (j == N || A[j] >= A[j+1])) {
                    foreach (k; 0..M) {
                        long stock = dp[i][k] / A[i];
                        long rest = dp[i][k] % A[i];
                        long gain = stock * A[j];
                        dp[j][k+1] = max(dp[j][k+1], rest + gain);
                    }
                }
            }
        }
        foreach (k; 0..M+1) {
            dp[i+1][k] = max(dp[i+1][k], dp[i][k]);
        }
    }

    dp[N].reduce!max.writeln;
}

