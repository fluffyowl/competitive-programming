import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long MOD = 10^^9 + 7;
immutable long INF = 1L << 59;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto K = s[1].to!long;
    auto A = readln.split.map!(to!long).array ~ K;
    A.sort();
    auto B = N.iota.map!(i => abs(A[i] - A[i+1])).reduce!gcd;
    B.writeln;
}
