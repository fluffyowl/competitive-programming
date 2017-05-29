import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto A = new int[](N+1);

    foreach (i; 0..M) {
        s = readln.split.map!(to!int);
        A[s[0]-1] += 1;
        A[s[1]-1] -= 1;
    }

    foreach (i; 0..N) {
        A[i+1] += A[i];
    }

    writeln((N-1).iota.map!(i => A[i] % 2 == 0).all ? "YES" : "NO");
}
