import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto K = s[1];
    auto P = N.iota.map!(_ => readln.chomp.to!int / 100.0L).array;

    auto dp = new real[][][](N+1, K, K); // i人目, 埋まっている1番右の座席, 虫食いの座席
    foreach (i; 0..N+1) foreach (j; 0..K) dp[i][j].fill(0);
    dp[1][0][0] = 1;

    foreach (i; 1..N) {
        foreach (j; 0..K) {
            foreach (k; 0..K) {
                if (j <= K-3 && k < K-1) {
                    dp[i+1][j+2][k+1] += dp[i][j][k] * (1 - P[i]);
                } else {
                    dp[i+1][j][k] += dp[i][j][k] * (1 - P[i]);
                }
                if (k == 0 && j <= K-2) {
                    dp[i+1][j+1][k] += dp[i][j][k] * P[i];
                } else if (k > 0) {
                    dp[i+1][j][k-1] += dp[i][j][k] * P[i];
                } else {
                    dp[i+1][j][k] += dp[i][j][k] * P[i];
                }
            }
        }
    }

    real ans = 0;
    foreach (j; 0..K) {
        foreach (k; 0..K) {
            int empty = (K - j - 1) + k;
            ans += dp[N][j][k] * empty;
        }
    }

    writefln("%.09f", ans);
}
