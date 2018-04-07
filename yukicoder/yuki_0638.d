import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

const long MOD = 10^^9 + 7;

void main() {
    auto N = readln.chomp.to!long;
    for (long a = 3; a < N; ++a) {
        long b = N - a;
        if (a.popcnt == 1 || b.popcnt == 1) continue;
        writeln(a, " ", b);
        return;
    }
    writeln(-1);
}

