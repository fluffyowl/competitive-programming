import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long MOD = 10^^9 + 7;

void main() {
    auto S = readln.chomp;
    auto N = S.length.to!int;
    auto D = readln.chomp.to!int;
    auto dp = new long[][](N+1, D+1);
    dp[0][0] = 1;

    foreach (i; 0..N) {
        foreach (j; 0..D+1) {
            int d = 0;
            foreach (k; 0..N) {
                if (i + k >= N) break;
                d *= 10;
                d += S[i+k] - '0';
                if (j + d > D) break;
                (dp[i+k+1][j+d] += dp[i][j]) %= MOD;
            }
        }
    }

    long ans = 0;
    foreach (j; 0..D+1) (ans += dp[N][j]) %= MOD;
    ans.writeln;
}
