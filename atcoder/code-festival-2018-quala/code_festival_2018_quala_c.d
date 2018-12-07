import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long MOD = 10^^9 + 7;

void main() {
    auto s = readln.split;
    auto N = s[0].to!int;
    auto K = s[1].to!long;
    auto A = readln.split.map!(to!long).array;
    auto cnt = new long[](N);
    long ans = 0;

    foreach (i; 0..N) {
        for (long a = A[i]; a > 0; a /= 2) {
            cnt[i]++;
        }
    }

    auto dp = new long[][][](N+1, 65*N, 2);
    //foreach (i; 0..N+1) foreach (j; 0..50*N) foreach (k; 0..2) dp[i][j][k] = -1;
    foreach (i; 0..N) if (A[i] == 0) dp[0][0][1] = 1;
    if (dp[0][0][1] == 0) dp[0][0][0] = 1;

    foreach (i; 0..N) {
        foreach (j; 0..65*N) {
            foreach (k; 0..2) {
                if (dp[i][j][k] == 0) continue;
                foreach (using; 0..cnt[i]+1) {
                    if (j + using > K) continue;
                    (dp[i+1][j+using][k||(using==cnt[i])] += dp[i][j][k]) %= MOD;
                }
            }
        }
    }

    //dp.each!writeln;
    foreach (j; 0..min(65*N, K+1)) (ans += dp[N][j][1]) %= MOD;
    if (K < 65*N) (ans += dp[N][K][0]) %= MOD;


    ans.writeln;
}
