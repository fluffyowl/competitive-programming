import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;

immutable long MOD = 10^^9 + 7;
immutable long MAX = 3 * 10^^5;
long[] F, G;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto P = s[2];
    auto V = readln.split.map!(to!long).array;
    V.sort!"a > b";

    F = new long[](MAX+1);
    G = new long[](MAX+1);
    F[0] = 1;
    foreach (i; 1..MAX+1) F[i] = F[i-1] * i % MOD;
    foreach (i; 0..MAX+1) G[i] = powmod(F[i], MOD-2, MOD);


    long ans = 0;
    long v = 0;

    foreach (i; 0..N) { // i回成功, M回失敗する
        long ok = i;
        long ng = M;
        long tmp = F[ok+ng-1] * G[ok] % MOD * G[ng-1] % MOD;
        long p1 = powmod(100-P, ok, MOD) * powmod(powmod(100, MOD-2, MOD), ok, MOD) % MOD;
        long p2 = powmod(P, ng, MOD) * powmod(powmod(100, MOD-2, MOD), ng, MOD) % MOD;
        ans += v * p1 % MOD * p2 % MOD * tmp % MOD;
        ans %= MOD;
        v = (v + V[i]) % MOD;
    }


    foreach (i; 0..M) { // N回成功, i回失敗する
        long ok = N;
        long ng = i;
        long tmp = F[ok+ng-1] * G[ok-1] % MOD * G[ng] % MOD;
        long p1 = powmod(100-P, ok, MOD) * powmod(powmod(100, MOD-2, MOD), ok, MOD) % MOD;
        long p2 = powmod(P, ng, MOD) * powmod(powmod(100, MOD-2, MOD), ng, MOD) % MOD;
        ans += v * p1 % MOD * p2 % MOD * tmp % MOD;
        ans %= MOD;
    }


    ans.writeln;
}

long comb(long n, long r) {
    if (n < r) return 0;
    return F[n] * G[n-r] % MOD * G[r] % MOD;
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

