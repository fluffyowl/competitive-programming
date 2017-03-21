import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

void main() {
    auto N = readln.chomp.to!long;
    long a = 0;
    long b = 0;
    foreach (i; 0..10^^6) {
        b += 1;
        a += b;
        if (a >= N) {
            b.writeln;
            return;
        }
    }
}
