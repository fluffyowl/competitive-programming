import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;


void main() {
    auto A = readln.split.map!(to!int);
    auto B = readln.split.map!(to!int);
    auto C = readln.chomp.to!int;

    int[int] ans;
    if (C == A[0]) ans[B[0]] = ans[B[1]] = true;
    if (C == A[1]) ans[B[0]] = ans[B[1]] = true;
    if (C == B[0]) ans[A[0]] = ans[A[1]] = true;
    if (C == B[1]) ans[A[0]] = ans[A[1]] = true;

    auto a = ans.keys.dup;
    a.sort();
    a.length.writeln;
    a.each!writeln;
}
