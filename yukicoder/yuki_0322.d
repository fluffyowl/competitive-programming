import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;

void main() {
    auto N = readln.chomp.to!int;
    auto T = readln.split.map!(to!int).array;
    auto D = readln.split.map!(to!int).array;
    auto A = N.iota.array;
    A.sort!((a, b) => T[b]*D[a] < T[a]*D[b])();
    A.map!(a => (a+1).to!string).join(" ").writeln;
}

