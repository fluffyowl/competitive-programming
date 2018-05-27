import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

immutable long MOD = 1000;

void main() {
    auto N = readln.chomp.to!int;
    long[][] m = [[1L, 3L], [1L, 1L]];
    m = powmod(m, N);
    long a = 2 * m[0][0] % MOD;
    if (N % 2 == 0) a = (a - 1 + MOD) % MOD;
    a.writeln;
}

long[][] mul(long[][] A, long[][] B) {
    auto n = A.length.to!int;
    auto ret = new long[][](n, n);
    foreach (i; 0..n)
        foreach (j; 0..n)
            foreach (k; 0..n)
                (ret[i][j] += A[i][k] * B[k][j]) %= MOD;
    return ret;
}

long[][] powmod(long[][] A, long x) {
    auto n = A.length.to!int;
    auto ret = new long[][](n, n);
    foreach (i; 0..n) ret[i][i] = 1;
    while (x) {
        if (x % 2) ret = mul(ret, A);
        A = mul(A, A);
        x /= 2;
    }
    return ret;
}

