import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long MOD = 10^^9 + 7;
immutable long INF = 1L << 59;


void main() {
    auto C = 3.iota.map!(_ => readln.split.map!(to!int).array).array;
    auto A = new int[][](3, 2);
    auto B = new int[][](2, 3);
    foreach (i; 0..3) A[i][0] = C[i][1] - C[i][0], A[i][1] = C[i][2] - C[i][1];
    foreach (i; 0..3) B[0][i] = C[1][i] - C[0][i], B[1][i] = C[2][i] - C[1][i];
    bool ok = true;
    foreach (i; 0..2) foreach (j; 0..2) if (A[i][j] != A[i+1][j]) ok = false;
    foreach (i; 0..2) foreach (j; 0..2) if (B[i][j] != B[i][j+1]) ok = false;
    writeln(ok ? "Yes" : "No");
}
