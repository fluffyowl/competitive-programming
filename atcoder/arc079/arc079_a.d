import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;


void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto edges = new int[][](N);
    foreach (_; 0..M) {
        s = readln.split.map!(to!int);
        auto a = s[0] - 1;
        auto b = s[1] - 1;
        edges[a] ~= b;
        edges[b] ~= a;
    }

    auto used = new bool[](N);
    foreach (i; edges[0]) {
        foreach (j; edges[i]) {
            used[j] = true;
        }
    }

    writeln(used[N - 1] ? "POSSIBLE" : "IMPOSSIBLE");
}
