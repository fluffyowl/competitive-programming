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

void main() {
    auto N = readln.chomp.to!long;
    if (N == 1) {
        writeln(13);
        return;
    }

    long[][] mat = [[1, 0, 0], [0, 0, 1], [1, 0, 10]];
    mat = matpow(mat, N-1);

    long ans = mat[2][0] * 3 % MOD + mat[2][2] * 13 % MOD;
    ans %= MOD;
    ans.writeln;
}

