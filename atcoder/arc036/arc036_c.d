import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio, std.bitmanip;

immutable long MOD = 10^^9+7;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto K = s[1];
    auto S = readln.chomp;

    auto dp = new int[][][](N+1, N+2, N+2); // pos, 0-1, 1-0
    dp[0][0][0] = 1;

    foreach (i; 0..N) {
        foreach (j; 0..K+1) {
            foreach (k; 0..K+1) {
                if (S[i] == '0')
                    dp[i+1][j+1][max(0, k-1)] += dp[i][j][k];
                else if (S[i] == '1')
                    dp[i+1][max(0, j-1)][k+1] += dp[i][j][k];
                else {
                    dp[i+1][j+1][max(0, k-1)] += dp[i][j][k];
                    dp[i+1][max(0, j-1)][k+1] += dp[i][j][k];
                }
                dp[i+1][j+1][max(0, k-1)] %= MOD;
                dp[i+1][max(0, j-1)][k+1] %= MOD;
            }
        }
    }


    //dp[N].writeln;
    long ans = 0;
    foreach (j; 0..K+1) foreach(k; 0..K+1) ans = (ans+dp[N][j][k]) % MOD;
    ans.writeln;
}
