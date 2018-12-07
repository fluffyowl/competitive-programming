import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long MAX = 10^^5 * 2;
immutable long MOD = 10^^9 + 7;
long[] F;
long[] G;

void main() {
    F = new long[](MAX);
    G = new long[](MAX);
    F[0] = F[1] = 1;
    foreach (i; 2..MAX) F[i] = F[i-1] * i % MOD;
    foreach (i; 0..MAX) G[i] = powmod(F[i], MOD-2, MOD);

    auto s = readln.split.map!(to!long);
    auto N = s[0].to!int;
    auto M = s[1];

    if (M == 1) {
        writeln(1);
        return;
    }

    long ans = 1;

    int[long] P;
    for (long i = 2; i * i <= M; ++i) {
        while (M % i == 0) P[i] += 1, M /= i;
    }
    if (M > 1) P[M] += 1;

    foreach (p; P.keys) {
        ans = ans * comb(N + P[p] - 1, P[p]) % MOD;
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
