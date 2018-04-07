import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto N = readln.chomp.to!int;
    auto A = (N-1).iota.map!(_ => readln.chomp.to!int).array;
    int ans = 0;
    int p = 0;

    foreach (i; 0..N-1) {
        auto s = readln.split.map!(to!int);
        p += s[1] - s[0];
        ans += p * A[i];
    }

    ans.writeln;
}

