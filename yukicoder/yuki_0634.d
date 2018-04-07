import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto N = readln.chomp.to!int;
    int[] A = [1];

    for (int i = 2; A.back + i <= N; ++i) {
        A ~= A.back + i;
    }

    if (A.back == N) {
        1.writeln;
        return;
    }
    
    foreach (a; A)
        foreach (b; A)
            if (a + b == N) {
                2.writeln;
                return;
            }

    3.writeln;
}

