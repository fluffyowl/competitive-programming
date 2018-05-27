import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!long).array;
    auto B = N.iota.map!(i => tuple(A[i], i)).array;
    B.sort();
    int k = N / 2;

    auto ans = new long[](N);

    foreach (i; 0..N) {
        if (i < k) {
            ans[B[i][1]] = B[k][0];
        } else {
            ans[B[i][1]] = B[k-1][0];
        }
    }

    ans.each!writeln;
}
