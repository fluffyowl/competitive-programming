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
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto C = [0] ~ readln.split.map!(to!int).array ~ [0];

    auto mat = new real[][](N, N+1);
    foreach (i; 0..N) foreach(j; 0..N+1) mat[i][j] = 0;
    mat[N-1][N-1] = -1;
    foreach (i; 0..N-1) {
        foreach (j; 1..M+1) {
            auto next = (i+j < N) ? i+j : 2*N-i-j-2;
            mat[i][next] += 1.0L / M;
        }
        mat[i][i] -= 1;
        mat[i][N] = -C[i];
    }
            
    auto E = new real[](N);
    gaussianElimination(mat, E);

    auto dp = new real[](N);
    foreach (i; iota(N-1, -1, -1)) {
        if (i+M >= N-1)
            dp[i] = C[i];
        else {
            // mahou tsukawanai
            dp[i] = C[i];
            foreach (j; 1..M+1)
                dp[i] += dp[i+j] / M;
            // tsukau
            foreach (j; 1..M+1)
                dp[i] = min(dp[i], C[i]+E[i+j]);
        }
        
    }

    writefln("%.9f", dp[0]);
}


