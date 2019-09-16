import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto A = readln.split.map!(to!long).array;
    auto B = readln.split.map!(to!long).array;

    int[long] mp;
    foreach (a; A) mp[a] += 1;
    B.map!(b => b in mp ? mp[b] : 0).map!(to!string).join(" ").writeln;
}

