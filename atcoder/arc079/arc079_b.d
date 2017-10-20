import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;


void main() {
    auto K = readln.chomp.to!long;

    int N = 50;
    auto A = new long[](N);

    auto X = K / 50;
    auto Y = K % 50;

    foreach (i; 0..N) {
        A[i] = 49 + X;
    }

    foreach (i; 0..Y) {
        A[i] += N;
        foreach (j; 0..N) if (j != i) A[j] -= 1;
    }

    N.writeln;
    A.map!(a => a.to!string).join(" ").writeln;
}
