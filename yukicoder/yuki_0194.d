import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;


immutable long MOD = 10^^9 + 7;
int N;
long K;
long[] A, B;
 
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

void solve1() {
    // N <= 30
    
    auto F_mat = new long[][](N, N);
    foreach (i; 0..N)
        foreach (j; 0..N)
            F_mat[i][j] = (i == 0 || i == j+1) ? 1 : 0;
    F_mat = matpow(N, K-N, F_mat);
    
    long F = 0;
    foreach (i; 0..N)
        (F += F_mat[0][i] * A[$-i-1] % MOD) %= MOD;
    

    auto S_mat = new long[][](N+1, N+1);
    foreach (i; 0..N+1)
        foreach (j; 0..N+1) {
            if (i == 0 && j == 0) S_mat[i][j] = 2;
            else if (i == 0 && j == N) S_mat[i][j] = -1;
            else if (i == j+1) S_mat[i][j] = 1;
            else S_mat[i][j] = 0;
        }
    S_mat = matpow(N+1, K-N, S_mat);
    
    long S = 0;
    foreach (i; 0..N+1)
        (S += S_mat[0][i] * B[$-i-1] % MOD) %= MOD;

    writeln(F, " ", S>=0 ? S:MOD+S);
}

void solve2() {
    auto F = new long[](K.to!int+1);
    F[N] = 0;
    foreach (i; 0..N) {
        F[i] = A[i];
        (F[N] += A[i] % MOD) %= MOD;
    }
    foreach (i; N+1..K.to!int)
        F[i] = (F[i-1] - F[i-N-1] + F[i-1]) % MOD;
    
    long S = 0;
    foreach (i; 0..K.to!int)
        S = (S + F[i]) % MOD;

    auto f = F[K.to!int-1];
    writeln(f>=0 ? f:MOD+f, " ", S>=0 ? S:MOD+S);
}

void main() {
    auto s = readln.split;
    N = s[0].to!int;
    K = s[1].to!long;
    A = readln.split.map!(to!long).array;
    B = new long[](N+1);
    B[0] = 0;
    foreach (i; 0..N)
        B[i+1] = B[i] + A[i];

    N <= 30 ? solve1 : solve2;

    //solve2;
}

