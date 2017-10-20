import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

const long INF = 1L << 59;
const long MOD = 10 ^^ 9 + 7;

void main() {
    auto N = readln.chomp.to!int;
    auto s = readln.split.map!(to!long);
    auto C = s[0];
    auto V = s[1];
    auto dp = new long[](2 * N + 1);
    fill(dp, INF);
    dp[1] = 0;

    foreach (i; 1..N) {
        long cost = (dp[i] + C) % MOD;
        for (int j = i + i; j <= 2 * N; j += i) {
            cost = (cost + V) % MOD;
            dp[j] = min(dp[j], cost);
        }
    }

    dp[N..2*N+1].reduce!min.writeln;
}

