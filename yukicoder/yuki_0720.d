import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long MOD = 10^^9 + 7;


void main() {
    auto s = readln.split.map!(to!long);
    auto N = s[0];
    auto M = s[1];
    long[][] hoge = [[1, 1], [1, 0]];
    auto F1 = matpow(hoge, M*N+M-1)[0][0];
    auto F2 = matpow(hoge, M*N-1)[0][0];
    auto F3 = matpow(hoge, M-1)[0][0];
    auto LM = matpow(hoge, M-2);
    auto L = (LM[0][0] * 3 + LM[0][1]) % MOD;
    long sign;
    if (M % 2) sign = -1;
    else sign = 1;
    long tmp1 = (F1 - sign * F2 - F3) % MOD;
    long tmp2 = (L - sign - 1);
    long ans = tmp1 * powmod(tmp2, MOD-2) % MOD;
    ans = (ans + MOD) % MOD;
    ans.writeln;
}

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

