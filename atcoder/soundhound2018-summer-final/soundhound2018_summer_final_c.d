import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long MOD = 10^^9 + 7;
long[] F;
long[] G;

void main() {
    F = new long[](50);
    G = new long[](50);
    F[0] = F[1] = 1;
    foreach (i; 2..50) F[i] = F[i-1] * i % MOD;
    foreach (i; 0..50) G[i] = powmod(F[i], MOD-2, MOD);

    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto D = s[1];

    auto dp = new long[][][](N, N+1, N+1);
    dp[0][1][1] = 1;

    foreach (d; 1..N) {
        foreach (using; 1..N+1) {
            foreach (used; 1..N+1) {
                if (using + used > N) continue;
                foreach (last; 1..N+1) {
                    long rest = d <= D ? N - used - 1 : N - used;
                    long k = d == D ? using - 1 : using;
                    if (rest < k) continue;
                    long tmp = comb(rest, k);
                    tmp = tmp * powmod(powmod(2, last, MOD) - 1, using, MOD) % MOD;
                    tmp = tmp * powmod(2, using * (using - 1) / 2, MOD) % MOD;
                    (dp[d][using+used][using] += dp[d-1][used][last] * tmp % MOD) %= MOD;
                }
            }
        }
    }

    long ans = 0;
    foreach (d; D..N)
        foreach (n; d+1..N+1)
            foreach (last; 0..N+1) {
                long tmp = dp[d][n][last];
                tmp = tmp * powmod(2, (N-n)*(N-n-1)/2, MOD) % MOD;
                ans = (ans + tmp) % MOD;
            }
    ans.writeln;
}

long powmod(long a, long x, long m) {
    a %= m;
    long ret = 1;
    while (x) {
        if (x % 2) ret = ret * a % m;
        a = a * a % m;
        x /= 2;
    }
    return ret;
}

long comb(long n, long k) {
    return F[n] * G[n-k] % MOD * G[k] % MOD;
}
