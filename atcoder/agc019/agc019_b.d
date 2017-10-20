import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto S = readln.chomp;
    auto N = S.length.to!int;
    auto C = new long[](26);
    foreach (i; 0..N) C[S[i] - 'a'] += 1;

    long ans = N.to!long * (N - 1).to!long / 2;

    foreach (i; 0..26) {
        ans -= C[i] * (C[i] - 1) / 2;
    }

    writeln(ans + 1);
}
