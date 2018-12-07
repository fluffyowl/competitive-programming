import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long MOD = 10^^9 + 7;

void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!int).array;

    int x1 = (N+1)/2;
    int x2 = N/2;
    int[int] c1;
    int[int] c2;

    for (int i = 0; i < N; i += 2) c1[A[i]] += 1;
    for (int i = 1; i < N; i += 2) c2[A[i]] += 1;
    c1[-1] = 0;
    c2[-2] = 0;

    auto A1 = c1.keys.dup;
    auto A2 = c2.keys.dup;
    A1.sort!((a, b) => c1[a] > c1[b]);
    A2.sort!((a, b) => c2[a] > c2[b]);
    A1 = A1[0..min(A1.length, 3)] ~ -1;
    A2 = A2[0..min(A2.length, 3)] ~ -2;

    int ans = 1 << 29;

    foreach (a; A1)
        foreach (b; A2)
            if (a != b)
                ans = min(ans, x1-c1[a] + x2-c2[b]);

    ans.writeln;
}
