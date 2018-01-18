import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.datetime;

void main() {
    auto s = readln.split.map!(to!int).array;
    auto N = s[0];
    auto M = s[1];
    auto A = readln.split.map!(to!int).array;
    auto G = new int[][](N);
    foreach (_; 0..M) {
        s = readln.split.map!(to!int).array;
        G[s[0]-1] ~= s[1]-1;
        G[s[1]-1] ~= s[0]-1;
    }

    foreach (i; 0..N) {
        bool[int] hoge;
        foreach (j; G[i]) hoge[A[j]] = true;
        auto fuga = hoge.keys.array;
        fuga.sort();
        if (fuga.length >= 2 && fuga[0] < A[i] && fuga[1] < A[i]) {
            "YES".writeln;
            return;
        }
        if (fuga.length >= 2 && fuga[$-1] > A[i] && fuga[$-2] > A[i]) {
            "YES".writeln;
            return;
        }
    }

    "NO".writeln;
}

