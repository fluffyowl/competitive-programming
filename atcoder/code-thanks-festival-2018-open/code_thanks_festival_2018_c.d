import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip, core.stdc.string;

void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!long).array;
    A.sort();

    long tmp = 0;
    long ans = 0;

    foreach (i; 1..N) {
        long d = A[i] - A[i-1];
        tmp += d * i;
        ans += tmp;
    }

    ans.writeln;
}
