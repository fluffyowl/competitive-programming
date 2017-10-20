import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;


void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!int).array;
    A.sort();
    int ans = A[N-1];
    foreach (i; 0..N-1) ans += A[i] / 2;
    ans.writeln;
}

