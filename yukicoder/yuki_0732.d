import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long MOD = 10^^9 + 7;
immutable long INF = 1L << 59;

void main() {
    auto N = readln.chomp.to!int;

    int[] P;
    auto is_P = new bool[](3*N+1);
    fill(is_P, true);
    is_P[0] = is_P[1] = false;

    foreach (i; 2..3*N+1) {
        if (!is_P[i]) continue;
        P ~= i;
        for (int j = i + i; j < 3*N+1; j += i) is_P[j] = false;
    }

    int M = P.length.to!int;
    auto P1 = P.filter!(p => p <= N && p % 3 == 1).array;
    auto P2 = P.filter!(p => p <= N && p % 3 == 2 && p != 2).array;
    auto A = new long[](3*N+1);
    auto B = new long[](3*N+1);
    foreach (i; 0..P1.length) foreach (j; i+1..P1.length) A[P1[i]+P1[j]] += 1;
    foreach (i; 0..P2.length) foreach (j; i+1..P2.length) B[P2[i]+P2[j]] += 1;

    long ans = 0;
    foreach (p; P) if (p >= 3) ans += A[p - 3] + B[p - 3];
    foreach (p1; P1) foreach (p; P) if (p - p1 > 0) ans += B[p - p1]; //, writeln(p, " ", p1, " ", B[p - p1]);
    foreach (p2; P2) foreach (p; P) if (p - p2 > 0) ans += A[p - p2]; //, writeln(p, " ", p2, " ", A[p - p2]);
    ans.writeln;
}

