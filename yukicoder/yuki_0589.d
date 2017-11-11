import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto N = readln.chomp.to!long;

    if (N <= 1) {
        writeln(0);
        return;
    }

    long ans = 1L << N.popcnt;
    writeln(N - ans + 1);
}

