import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

immutable long MOD = 10^^9+7;

void main() {
    auto N = readln.chomp.to!int;

    if (N <= 2) {
        writeln(0);
        return;
    }
    
    auto dp = new long[][][](N+1, 2, 2); // i, 左端, 右端
    dp[0][0][1] = 1;
    dp[0][1][0] = 1;
    dp[1][0][0] = 1;
    dp[2][1][0] = 1;
    dp[2][0][1] = 1;
    dp[3][0][0] = 2;
    dp[3][1][1] = 2;

    foreach (i; 4..N+1) {
        long comb = 1;
        foreach (j; 0..i) {
            int k = i - j - 1;
            (dp[i][0][0] += dp[j][0][0] * dp[k][0][0] % MOD * comb % MOD) %= MOD;
            (dp[i][1][0] += dp[j][1][0] * dp[k][0][0] % MOD * comb % MOD) %= MOD;
            (dp[i][0][1] += dp[j][0][0] * dp[k][0][1] % MOD * comb % MOD) %= MOD;
            (dp[i][1][1] += dp[j][1][0] * dp[k][0][1] % MOD * comb % MOD) %= MOD;
            comb = comb * k % MOD * powmod(j + 1, MOD-2, MOD) % MOD;
        }
    }

    writeln((dp[N][0].sum + dp[N][1].sum) % MOD);
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

