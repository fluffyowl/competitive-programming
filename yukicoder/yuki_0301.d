import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

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


void solve(int K) {
    auto mat = new real[][](K, K+1);
    foreach (i; 0..K) foreach(j; 0..K+1) mat[i][j] = 0;
    foreach (i; 0..K) {
        foreach (j; 1..7) {
            auto next = (i+j > K) ? 0 : i+j;
            mat[i][K] -= 1.0L / 6;
            if (i + j != K)
                mat[i][next] += 1.0L/6;
        }
        mat[i][i] -= 1;
    }

    auto E = new real[](K);
    gaussianElimination(mat, E);

    writefln("%.15f", E[0]);
}

void main() {
    auto T = readln.chomp.to!int;
    while (T--) {
        auto N = readln.chomp.to!long;
        if (N <= 190) solve(N.to!int);
        else writefln("%.15f", N + 5.0L / 3);
    }
}

