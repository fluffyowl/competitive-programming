import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;


int bool_det(ref int[][] org_mat) {
    int N = org_mat.length.to!int;

    auto mat = new int[][](N, N);
    foreach (i; 0..N)
        foreach (j; 0..N)
            mat[i][j] = org_mat[i][j];

    foreach (i; 0..N) {
        int maxval = 0;
        int maxrow = -1;
        foreach (j; i..N)
            if (abs(mat[j][i]) > maxval)
                maxval = abs(mat[j][i]), maxrow = j;
        if (maxval == 0) {
            return 0;
        }
        swap(mat[i], mat[maxrow]);

        foreach (j; i+1..N) {
            int a = mat[j][i];
            foreach (k; i..N) {
                mat[j][k] ^= a * mat[i][k];
            }
        }
    }

    int ans = 1;
    foreach (i; 0..N) ans *= mat[i][i];
    return ans;
}


void main() {
    auto N = readln.chomp.to!int;
    auto A = N.iota.map!(_ => readln.chomp.map!(x => x.to!string.to!int).array).array;
    (bool_det(A) ? "Odd" : "Even").writeln;
}
