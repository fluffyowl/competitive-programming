import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;

immutable long MOD = 10^^9 + 7;

long[][] matmul(long[][] m1, long[][] m2) {
    int n = m1.length.to!int;
    long[][] ret = new long[][](n, n);
    
    foreach (i; 0..n) foreach (j; 0..n) foreach (k; 0..n) {
        (ret[i][j] += m1[i][k] * m2[k][j] % MOD) %= MOD;
    }

    return ret;
}

long[][] matpow(long[][] m, long x) {
    int n = m.length.to!int;
    long[][] ret = new long[][](n, n);
    foreach (i; 0..n) ret[i][i] = 1;

    while (x) {
        if (x % 2) ret = matmul(ret, m);
        m = matmul(m, m);
        x /= 2;
    }

    return ret;
}

long powmod(long a, long x) {
    long ret = 1;
    while (x) {
        if (x & 1) ret = ret * a % MOD;
        a = a * a % MOD;
        x /= 2;
    }
    return ret;
}

void main() {
    auto N = readln.chomp.to!long;

    long[][] hoge = [[1, 1], [1, 0]];
    long ans = 1;

    foreach (i; 0..N) {
        auto s = readln.split;
        auto C = s[0].to!long;
        auto D = s[1].to!BigInt % (MOD - 1);
        if (D == 0) D = MOD - 1;
        auto F = matpow(hoge, C+1)[0][0];
        ans = ans * powmod(F, D) % MOD;
    }

    ans.writeln;
}

