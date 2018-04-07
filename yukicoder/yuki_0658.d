import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long MOD = 17;

void main() {
    long[][] mat = [[1, 1, 1, 1],
                    [1, 0, 0, 0],
                    [0, 1, 0, 0],
                    [0, 0, 1, 0]];

    auto Q = readln.chomp.to!int;
    while (Q--) {
        auto N = readln.chomp.to!long;
        auto A = powmod(mat, N);
        A[3][3].writeln;
    }
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

