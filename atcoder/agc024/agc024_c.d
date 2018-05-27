import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto N = readln.chomp.to!int;
    auto A = N.iota.map!(_ => readln.chomp.to!long).array;

    if (A[0] != 0) {
        writeln(-1);
        return;
    }

    if ((N-1).iota.map!(i => A[i+1] - A[i] > 1).any) {
        writeln(-1);
        return;
    }

    long ans = 0;
    foreach (i; 1..N) {
        if (A[i] - A[i-1] == 1)
            ans += 1;
        else if (A[i] > 0)
            ans += A[i];
    }

    ans.writeln;
}
