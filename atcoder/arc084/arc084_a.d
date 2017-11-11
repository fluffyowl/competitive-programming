import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!int).array;
    auto B = readln.split.map!(to!int).array;
    auto C = readln.split.map!(to!int).array;
    A.sort();
    B.sort();
    C.sort();
    long ans = 0;

    foreach (b; 0..N)
        ans += A.assumeSorted.lowerBound(B[b]).length.to!long * C.assumeSorted.upperBound(B[b]).length.to!long;

    ans.writeln;
}
