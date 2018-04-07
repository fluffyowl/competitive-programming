import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    immutable int M = 51;
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!int);
    auto B = readln.split.map!(to!int);
    auto S = iota(1, M).array;

    bool ok() {
        auto D = new int[][](M, M);
        foreach (i; 0..M) foreach (j; 0..M) D[i][j] = i == j ? 1 : 1 << 29;
        foreach (i; 0..M) foreach (j; S) D[i][i%j] = 1;
        foreach (i; 0..M) foreach (j; 0..M) foreach (k; 0..M) D[j][k] = min(D[j][k], D[j][i] + D[i][k]);
        return N.iota.map!(i => D[A[i]][B[i]] < 1 << 29).all;
    }

    if (!ok) {
        writeln(-1);
        return;
    }
    
    ulong ans = 0;
    foreach (i; iota(50, 0, -1)) {
        S = S.remove!(a => a == i);
        if (!ok) {
            S ~= i;
            ans += 1UL << i;
        }
    }

    ans.writeln;
}
