import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto N = readln.chomp.to!int;
    auto A = N.iota.map!(_ => readln.split.map!(to!long).array).array;
    A.sort!"a[1]*b[0] < b[1]*a[0]";

    long S = A.map!(a => a[0]).sum;
    long ans = 0;
    foreach (i; 0..N) {
        ans += (S - A[i][0]) * A[i][1];
        S -= A[i][0];
    }

    ans.writeln;
}
