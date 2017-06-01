import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;


void main() {
    bool[int] set;
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!int).array;

    foreach (a; A) {
        while (a % 2 == 0) a /= 2;
        set[a] = true;
    }

    set.keys.length.writeln;
}
