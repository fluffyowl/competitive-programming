import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;


int gaussianElimination(ref real[][] org_mat, ref real[] ret) {
    int N = org_mat.length.to!int;

    auto mat = new real[][](N, N+1);
    foreach (i; 0..N)
        foreach (j; 0..N+1)
            mat[i][j] = org_mat[i][j];

    foreach (i; 0..N) {
        real maxval = 0;
        int maxrow = -1;
        foreach (j; i..N)
            if (abs(mat[j][i]) > maxval)
                maxval = abs(mat[j][i]), maxrow = j;
        if (maxval == 0)
            return -1;
        swap(mat[i], mat[maxrow]);

        foreach (j; i+1..N+1)
            mat[i][j] /= mat[i][i];
        mat[i][i] = 1;

        foreach (j; 0..N) {
            if (j == i) continue;
            real mul = mat[j][i];
            foreach (k; i..N+1)
                mat[j][k] -= mul*mat[i][k];
        }
    }

    foreach (i; 0..N)
        ret[i] = mat[i][N];

    return 0;
}


void main() {
    real[6] E = [1.0000000000000000,
                 1.0833333333333333,
                 1.2569444444444444,
                 1.5353009259259260,
                 1.6915991512345676,
                 2.0513639724794235];

    auto mat = new real[][](6, 7);
    foreach (i; 0..6) foreach(j; 0..7) mat[i][j] = 0;
    foreach (i; 0..6) {
        foreach (j; 1..7) {
            if (j >= i + 1)
                mat[i][j-1] += 1;
            else
                mat[i][j-1] += E[i-j]+1;
        }
        mat[i][6] = E[i];
    }

    auto P = new real[](6);
    gaussianElimination(mat, P);

    auto T = readln.chomp.to!int;
    while (T--) {
        auto N = readln.chomp.to!int;
        auto dp = new real[](N+1);
        foreach (i; 0..N+1)
            dp[i] = 0;
        foreach (i; iota(N-1, -1, -1)) {
            foreach (j; 1..7) {
                if (i + j >= N)
                    dp[i] += P[j-1];
                else
                    dp[i] += P[j-1] * (dp[i+j] + 1);
            }
        }
        writefln("%.10f", dp[0]);
    }
}

