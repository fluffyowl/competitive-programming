import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;

immutable long MOD = 998244353 ;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto K = s[1];
    auto M = K ^^ 3;

    auto mat = new long[][](M, M);
    foreach (mask; 0..M) {
        int c = mask % K;
        int b = mask / K % K;
        int a = mask / K / K;
        int na = (a + 1) % K;
        int nb = (b + a) % K;
        int nc = (c + b) % K;
        int x = na * K^^2 + b * K + c;
        int y = a * K^^2 + nb * K + c;
        int z = a * K^^2 + b * K + nc;
        mat[x][mask] += 1;
        mat[y][mask] += 1;
        mat[z][mask] += 1;
    }

    long ans = 0;
    auto nmat = matpow(M, N, mat);
    foreach (mask; 0..M) if (mask % K == 0) ans = (ans + nmat[mask][0]) % MOD;
    ans.writeln;
}

long[][] matmul(int N, long[][] m1, long[][] m2) {
    auto ret = new long[][](N, N);
    foreach (i; 0..N) {
        foreach (j; 0..N) {
            ret[i][j] = 0;
            foreach (k; 0..N) {
                (ret[i][j] += m1[i][k] * m2[k][j] % MOD) %= MOD;
            }
        }
    }
    return ret;
}

long[][] matpow(int N, long K, long[][] mat) {
    auto ret = new long[][](N, N);
    foreach (i; 0..N)
        foreach (j; 0..N)
            ret[i][j] = i == j ? 1 : 0;

    while (K > 0) {
        if (K % 2 == 1)
            ret = matmul(N, ret, mat);
        mat = matmul(N, mat, mat);
        K /= 2;
    }

    return ret;
}
