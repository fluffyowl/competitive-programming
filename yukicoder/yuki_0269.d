import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;


void main() {
    immutable long MOD = 10^^9+7;

    int N, S, K;
    scanf("%d %d %d", &N, &S, &K);

    auto dp = new long[][](N, S+1);
    foreach (i; 0..N) foreach (j; 0..S+1) dp[i][j] = 0;

    foreach (i; 0..S+1) {
        auto s = N * i;
        if (s > S)
            break;
        dp[0][s] = 1;
    }

    foreach (i; 1..N) {
        foreach (j; 0..S+1) {
            auto plus_k = j - (N-i)*K;
            auto plus_one = j - (N-i);
            if (plus_k >= 0 && plus_k <= S)
                dp[i][j] += dp[i-1][plus_k];
            if (plus_one >= 0 && plus_one <= S)
                (dp[i][j] += dp[i][plus_one]) %= MOD;
        }
    }

    dp[N-1][S].writeln;
}

