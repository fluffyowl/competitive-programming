import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

const long MOD = 10^^9 + 7;

void main() {
    auto s = readln.split.map!(to!long);
    auto N = s[0];
    auto L = s[1];
    auto R = s[2];
    auto A = readln.split.map!(to!long).array;
    long[] B;

    foreach (a; A) {
        a = max(L, a);
        a = min(R, a);
        B ~= a;
    }

    B.map!(b => b.to!string).join(" ").writeln;
}
