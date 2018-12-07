import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long MOD = 10^^9 + 7;

void main() {
    auto s = readln.split.map!(to!long);
    auto N = s[0];
    auto K = s[1];

    long[] F;
    for (long i = 1; i * i <= N; ++i) {
        if (N % i == 0) {
            F ~= N / i;
            F ~= i;
        }
    }
    F = F.sort().uniq().array;

    auto cnt = new long[](F.length);

    foreach (i; 0..F.length.to!int) {
        cnt[i] = powmod(K, (F[i]+1)/2, MOD);
        foreach (j; 0..i) {
            if (F[i] % F[j] == 0) {
                cnt[i] -= cnt[j];
                cnt[i] = (cnt[i] % MOD + MOD) % MOD;
            }
        }
    }

    long ans = 0;
    foreach (i; 0..F.length.to!int) {
        if (F[i] % 2 == 0) {
            ans = (ans + cnt[i] * F[i] / 2 % MOD) % MOD;
        } else {
            ans = (ans + cnt[i] * F[i] % MOD) % MOD;
        }
    }
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
