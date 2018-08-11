import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    immutable long MOD = 924844033;

    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto K = s[1];

    auto F = new long[](N+1);
    F[0] = F[1] = 1;
    foreach (i; 2..N+1)
        F[i] = F[i-1] * i % MOD;

    auto C = new long[][](N+10, N+10) ;
    C[0][0] = 1;
    foreach (i; 0..N+9) {
        foreach (j; 0..N+9) {
            (C[i+1][j] += C[i][j]) %= MOD;
            (C[i+1][j+1] += C[i][j]) %= MOD;
        }
    }
    

    auto dp = new long[][][](N+1, N+1, 2);
    dp[0][0][0] = 1;

    foreach (i; 0..N) {
        foreach (j; 0..N) {
            dp[i+1][j][0] = (dp[i][j][0] + dp[i][j][1]) % MOD;
            dp[i+1][j+1][1] = dp[i][j][0];
        }
    }

    auto dp2 = new long[][](2, N+1);
    dp2[0][0] = 1;
    int cur = 0, tar = 1;
    
    foreach (_; 0..2) {
        for (int i = 0; i < K; ++i) {
            int n = N / K;
            if (i < N % K) n += 1;
            for (int j = 0; j <= N; ++j) {
                for (int k = 0; j + k <= N && k <= n; ++k) {
                    dp2[tar][j+k] += dp2[cur][j] * dp[n-1][k].sum % MOD;
                    dp2[tar][j+k] %= MOD;
                }
            }
            swap(cur, tar);
            fill(dp2[tar], 0L);
        }
    }


    for (int i = N; i >= 0; --i) {
        dp2[cur][i] = dp2[cur][i] * F[N-i] % MOD;
        for (int j = i + 1; j <= N; ++j) {
            (dp2[cur][i] -= dp2[cur][j] * C[j][i] % MOD) %= MOD;
        }
    }

    writeln((dp2[cur][0] + MOD) % MOD);
}
