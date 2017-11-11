import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

immutable long MOD = 10^^9+7;

void main() {
    auto s = readln.split.map!(to!int);
    auto H = s[0];
    auto R = s[1];
    auto G = R.iota.map!(_ => readln.split.map!(to!int).array).array;

    
    auto dp = new long[][][](R, R, 1 << R);
    foreach (i; 0..R) dp[i][i][1<<i] = 1;
    auto masks = (1<<R).iota.array.sort!((a, b) => a.popcnt < b.popcnt).array;

    foreach (i; 0..R) // 出発
        foreach (mask; masks)
            foreach (j; 0..R) // 経由
                foreach (k; 0..R) { // 到着
                    if (!(mask & (1 << i))) continue;
                    if (!(mask & (1 << j))) continue;
                    if ((mask & (1 << k))) continue;
                    if (!G[j][k]) continue;
                    (dp[i][k][mask|(1<<k)] += dp[i][j][mask]) %= MOD;
                }

    
    auto mat = new long[][](R, R);
    foreach (i; 0..R)
        foreach (j; 0..R)
            foreach (mask; 0..1<<R)
                (mat[i][j] += dp[i][j][mask]) %= MOD;

    matpow(R, H, mat)[0][0].writeln;
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
