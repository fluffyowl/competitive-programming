import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;


void main() {
    auto N = readln.chomp.to!int;
    auto D = N.iota.map!(_ => readln.split.map!(to!int).array).array;
    auto Q = readln.chomp.to!int;
    auto P = Q.iota.map!(_ => readln.chomp.to!int).array;

    auto acm = new int[][](N+1, N+1);
    foreach (i; 0..N)
        foreach (j; 0..N)
            acm[i+1][j+1] = acm[i+1][j] + D[i][j];
    foreach (j; 0..N)
        foreach (i; 0..N)
            acm[i+1][j+1] += acm[i][j+1];

    int acm2d(int r1, int c1, int r2, int c2) {
        return acm[r2+1][c2+1] - acm[r1][c2+1] - acm[r2+1][c1] + acm[r1][c1];
    }

    auto ans = new int[](N*N+1);
    foreach (i; 1..N*N+1) {
        for (int h = 1; h <= i; h++) {
            if (i % h != 0) continue;
            int w = i / h;
            foreach (r; 0..(N-h+1))
                foreach (c; 0..(N-w+1))
                    ans[i] = max(ans[i], acm2d(r, c, r+h-1, c+w-1));
        }
        ans[i] = max(ans[i-1], ans[i]);
    }

    foreach (p; P)
        ans[p].writeln;
}
