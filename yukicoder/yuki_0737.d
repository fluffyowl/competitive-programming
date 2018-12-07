import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long MOD = 10^^9 + 7;
immutable int MAX = 100;
auto F = new long[](MAX);
auto G = new long[](MAX);
auto P = new long[](MAX);

void main() {
    F[0] = 1, G[0] = 1, P[0] = 1;
    foreach (i; 1..MAX) F[i] = F[i-1] * i % MOD;
    foreach (i; 1..MAX) G[i] = powmod(F[i], MOD-2, MOD);
    foreach (i; 1..MAX) P[i] = P[i-1] * 2 % MOD;

    auto N = readln.chomp.to!long;
    long[] dp = new long[](MAX);

    for (long n = N, popcnt = 0, s = 0; n > 0; n = n - (1L << bsr(n)), popcnt += 1) {
        long b = 1L << bsr(n);
        long m = n - b;
        dp[popcnt + 1] += s + b;
        // 先頭が0のとき
        foreach (i; 1..bsr(n)+1) {
            long c = comb(bsr(n)-1, i-1);
            (dp[popcnt+i] += comb(bsr(n), i) * s % MOD) %= MOD;
            foreach (j; 0..bsr(n)) {
                (dp[popcnt+i] += c * P[j] % MOD) %= MOD;
            }
        }
        s += b;
        s %= MOD;
    }

    long ans = 0;
    foreach (i; 0..MAX) (ans += dp[i] * i % MOD) %= MOD;
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

long comb(long n, long r) {
    return F[n] * G[n-r] % MOD * G[r] % MOD;
}

