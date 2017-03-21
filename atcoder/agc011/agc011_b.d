import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!long).array;
    A.sort();

    auto B = new long[](N);
    B[0] = A[0];
    foreach (i; 1..N) {
        B[i] = B[i-1] + A[i];
    }

    int ans = 1;
    for (int i = N-2; i >= 0; i--) {
        if (B[i]*2 < A[i+1]) break;
        ans += 1;
    }

    ans.writeln;
}
