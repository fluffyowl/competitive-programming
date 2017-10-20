import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!long).array;
    long a = 0, b = A.sum;
    long ans = 1L << 60;

    foreach (i; 0..N) {
        if (i != 0) {
            ans = min(ans, abs(a - b));
        }
        a += A[i], b -= A[i];
    }

    ans.writeln;
}
