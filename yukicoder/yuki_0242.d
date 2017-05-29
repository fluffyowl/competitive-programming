import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;


void main() {
    auto N = readln.chomp.to!int;
    real ans = 12;
    foreach (i; 0..5) ans = ans * (N - i) / (99 - i);
    writefln("%.9f", ans);
}

