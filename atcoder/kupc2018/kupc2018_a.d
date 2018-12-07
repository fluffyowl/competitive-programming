import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto N = readln.chomp.to!int;
    auto S = readln.split.map!(to!int).array;
    auto A = readln.split.map!(to!int).array;
    N.iota.map!(i => S[i] * A[i]).reduce!max.writeln;
}
