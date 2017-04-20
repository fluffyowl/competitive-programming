import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;

int[] dr = [0, 0, 1, -1];
int[] dc = [1, -1, 0, 0];

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto C = N.iota.map!(_ => readln.chomp).array;
    auto A = new int[][](N, M);
    foreach (i; 0..N) foreach (j; 0..M) A[i][j] = C[i][j] - '0';
    auto B = new int[][](N, M);

    foreach (i; 1..N-1) {
        foreach (j; 1..M-1) {
            auto n = 4.iota.map!(k => A[i+dr[k]][j+dc[k]]).reduce!min;
            B[i][j] += n;
            foreach (k; 0..4) A[i+dr[k]][j+dc[k]] -= n;
        }
    }

    foreach (i; 0..N) {
        B[i].map!(i => i.to!string).join("").writeln;
    }
}
