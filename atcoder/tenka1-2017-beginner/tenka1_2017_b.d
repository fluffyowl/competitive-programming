import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto N = readln.chomp.to!int;
    auto A = N.iota.map!(_ => readln.split.map!(to!int).array).array;
    A.sort();
    long ans = N + A.front[0] - 1 + A.back[1];

    foreach (i; 0..N-1) {
        ans += min(A[i+1][0] - A[i][0] - 1, A[i][1] - A[i+1][1] - 1);
    }

    ans.writeln;
}
