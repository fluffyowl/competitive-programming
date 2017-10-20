import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

immutable long MOD = 10^^9 + 7;

void main() {
    auto s = readln.split.map!(to!long);
    auto N = s[0];
    auto K = s[1];

    long[] F;
    for (long i = 1; i * i <= K; i++) {
        if (i * i == K) F ~= i;
        else if (K % i == 0) F ~= i, F ~= K / i;
    }
    F.sort();


    auto ans = new long[](F.length);
    auto sums = new long[](F.length);
    
    for (int i = F.length.to!int - 1; i >= 0; i--) {
        long n = N / F[i];
        sums[i] = n * (2 * F[i] % MOD + (n - 1) * F[i] % MOD) % MOD * powmod(2, MOD-2, MOD) % MOD;

        for (int j = i + 1; j < F.length; j++) {
            if (F[j] % F[i] == 0) {
                sums[i] -= sums[j] % MOD;
                sums[i] = (sums[i] + MOD) % MOD;
            }
        }
        
        ans[i] = K * sums[i] % MOD * powmod(F[i], MOD-2, MOD) % MOD;
    }

    long ansans = 0;
    foreach (a; ans) ansans = (ansans + a) % MOD;
    ansans = (ansans + MOD) % MOD;
    ansans.writeln;
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
