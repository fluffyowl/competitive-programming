import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

const long MOD = 10^^9 + 7;

void main() {
    auto N = readln.chomp.to!int;
    auto A = 2.iota.map!(_ => readln.split.map!(to!long).array).array;

    foreach (j; 0..N-1) {
        A[0][j+1] += A[0][j];
    }

    for (int j = N-1; j > 0; --j) {
        A[1][j-1] += A[1][j];
    }

    long ans = 0;
    foreach (i; 0..N) {
        ans = max(ans, A[0][i] + A[1][i]);
    }

    ans.writeln;
}
