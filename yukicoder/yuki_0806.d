import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;

immutable long MOD = 10^^9 + 7;

void main() {
    auto N = readln.chomp.to!int;
    auto G = new int[][](N);
    foreach (_; 0..N-1) {
        auto s = readln.split.map!(to!int);
        G[s[0]-1] ~= s[1]-1;
        G[s[1]-1] ~= s[0]-1;
    }

    int ans = 0;
    foreach (i; 0..N) ans += max(0, G[i].length.to!int - 2);
    ans.writeln;
}

