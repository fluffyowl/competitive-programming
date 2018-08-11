import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long MOD = 998244353;
long[] F, G;

void main() {
    F = new long[](1500);
    G = new long[](1500);
    F[0] = F[1] = G[0] = G[1] = 1;
    foreach (i; 2..1500) F[i] = i * F[i-1] % MOD;
    foreach (i; 2..1500) G[i] = powmod(F[i], MOD-2, MOD);
    
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!int).array;
    
    auto cnt = new int[](N+1);
    foreach (a; A) cnt[a] += 1;
    
    auto dp = new long[][](N+2, N+1);
    dp[N+1][0] = 1;

    foreach_reverse (i; 1..N+1) {
        foreach (j; 0..N+1) {
            if (dp[i+1][j] == 0) {
                continue;
            }
            for (int k = 0, p = 0; k <= j + cnt[i]; k += i, p += 1) {
                long tmp;
                tmp = comb(j+cnt[i], k);
                tmp = tmp * F[k] % MOD * powmod(G[i], p, MOD) % MOD;
                tmp = tmp * G[p] % MOD;
                dp[i][j+cnt[i]-k] += dp[i+1][j] * tmp % MOD;
                dp[i][j+cnt[i]-k] %= MOD;
            }
        }
    }

    dp[1][0].writeln;
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

long comb(int n, int r) {
    return F[n] * G[r] % MOD * G[n-r] % MOD;
}
