import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

immutable long MOD = 10^^9 + 7;

long[][] matmul(int N, long[][] m1, long[][] m2, long mod) {
    auto ret = new long[][](N, N);
    foreach (i; 0..N) {
        foreach (j; 0..N) {
            ret[i][j] = 0;
            foreach (k; 0..N) {
                (ret[i][j] += m1[i][k] * m2[k][j] % mod) %= mod;
            }
        }
    }
    return ret;
}

long[][] matpow(int N, long K, long[][] mat, long mod) {
    auto ret = new long[][](N, N);
    foreach (i; 0..N)
        foreach (j; 0..N)
            ret[i][j] = i == j ? 1 : 0;

    while (K > 0) {
        if (K % 2 == 1)
            ret = matmul(N, ret, mat, mod);
        mat = matmul(N, mat, mat, mod);
        K /= 2;
    }

    return ret;
}



void main() {
    auto N = readln.chomp.to!long;
    if (N == 0) {
        0.writeln;
        return;
    }
    long[][] F_mat = [[1, 1], [1, 0]];
    long[][] X = matpow(2, N-1, F_mat, 2*(MOD+1));
    long[][] Y = matpow(2, X[0][0], F_mat, MOD);
    Y[0][1].writeln;
}

