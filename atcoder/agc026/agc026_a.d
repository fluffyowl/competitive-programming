import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!int).array;
    int ans = 0;

    for (int i = 1; i < N; ++i) {
        if (A[i] == A[i-1]) {
            ans += 1;
            i += 1;
        }
    }

    ans.writeln;
}
