import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto N = readln.chomp.to!int;

    foreach (a; 1..N+1)
        foreach (b; 1..N+1) {
            int c = N - a - b;
            if (a <= b && b <= c && c > 0) writeln(a, " ", b, " ", c);
        }
}

