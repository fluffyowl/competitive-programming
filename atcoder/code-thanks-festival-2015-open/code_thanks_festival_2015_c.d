import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;


void main() {
    auto N = readln.chomp.to!int;
    auto H = readln.split.map!(to!int).array;
    auto X = readln.chomp.to!int;

    foreach (i; 0..N) {
        if (X < H[i]) {
            writeln(i+1);
            return;
        }
    }
    writeln(N+1);
}
