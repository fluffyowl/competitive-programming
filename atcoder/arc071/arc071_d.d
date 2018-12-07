import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long MOD = 10^^9 + 7;

void main() {
    auto N = readln.chomp.to!int;

    auto dp = new long[][](N+1, 2);
    dp[0][1] = 1;

    auto imos = new long[](3*N);
    long INV = powmod(N-1, MOD-2, MOD);
    long ans = 0;

    foreach (i; 0..N) {
        (dp[i+1][0] += dp[i][1] * (N - 1) % MOD) %= MOD; // 1のあとに2〜N
        (dp[i+1][1] += dp[i][1]) %= MOD; // 1のあとに1
        (dp[N][0] += dp[i][0] * (N - 1) % MOD) %= MOD; // 2〜Nのあとに2〜N (無限ループ)

        // 2〜Nのあとに1
        (imos[i+2] += dp[i][0] * INV % MOD) %= MOD;
        (imos[i+N+1] -= dp[i][0] * INV % MOD) %= MOD;

        (imos[i+1] += imos[i]) %= MOD;
        (dp[i+1][1] += imos[i+1]) %= MOD;
    }

    foreach (i; N..3*N-1) {
        (imos[i+1] += imos[i]) %= MOD;
        (ans += imos[i+1]) %= MOD;
    }

    ans = (ans + dp[N].sum % MOD + MOD) % MOD;
    ans.writeln;
}

long powmod(long a, long x, long m) {
    long ret = 1;
    while (x) {
        if (x % 2) ret = ret * a % m;
        a = a * a % m;
        x /= 2;
    }
    return ret;
}
