import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto N = readln.chomp.to!int;
    auto D = readln.split.map!(to!int).array;
    auto M = readln.chomp.to!int;
    auto T = readln.split.map!(to!int).array;

    int[int] A;
    foreach (t; T) A[t] += 1;
    foreach (d; D) A[d] -= 1;

    writeln((A.values.map!(a => a <= 0).all) ? "YES" : "NO");
}
