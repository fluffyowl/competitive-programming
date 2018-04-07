import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long INF = 1L << 59;

void main() {
    auto T = new int[](10^^6+1);

    T[4] = 1;

    foreach (i; 5..10^^6+1) {
        T[i] = T[i-1] + T[i-2] + T[i-3] + T[i-4];
        T[i] %= 17;
    }

    auto Q = readln.chomp.to!int;
    while (Q--) {
        T[readln.chomp.to!int].writeln;
    }
}

