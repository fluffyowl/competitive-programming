import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto s = readln.split.map!(to!int);
    auto H = s[0];
    auto W = s[1];
    auto A = H.iota.map!(_ => readln.chomp).array;

    auto L = new long[][](H, W);
    auto R = new long[][](H, W);
    auto U = new long[][](H, W);
    auto D = new long[][](H, W);

    foreach (i; 0..H)
        foreach (j; 0..W-1)
            if (A[i][j] == '.' && A[i][j+1] == '.')
                L[i][j+1] = L[i][j] + 1;

    foreach (i; 0..H)
        foreach_reverse (j; 1..W)
            if (A[i][j] == '.' && A[i][j-1] == '.')
                R[i][j-1] = R[i][j] + 1;

    foreach (j; 0..W)
        foreach (i; 0..H-1)
            if (A[i][j] == '.' && A[i+1][j] == '.')
                U[i+1][j] = U[i][j] + 1;

    foreach (j; 0..W)
        foreach_reverse (i; 1..H)
            if (A[i][j] == '.' && A[i-1][j] == '.')
                D[i-1][j] = D[i][j] + 1;

    long ans = 0;
    foreach (i; 0..H)
        foreach (j; 0..W)
            if (A[i][j] == '.') {
                ans += D[i][j] * R[i][j];
                ans += R[i][j] * U[i][j];
                ans += U[i][j] * L[i][j];
                ans += L[i][j] * D[i][j];
            }

    ans.writeln;
}
