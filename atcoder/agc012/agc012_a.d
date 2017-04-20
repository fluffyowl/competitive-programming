import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;


void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!long).array;
    A.sort();

    long ans = 0;
    foreach (i; iota(N, 3*N, 2)) {
        ans += A[i];
    }

    ans.writeln;
}
