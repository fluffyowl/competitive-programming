import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;


void main() {
    auto N = readln.chomp.to!int;
    auto S = N.iota.map!(_ => readln.chomp.to!int).array;
    auto T = N.iota.map!(i => S.sum-S[i]).array;
    auto U = new bool[][](N, N);
    foreach (i; 0..N) foreach (j; 0..N) U[i][j] = i == j;
    auto M = readln.chomp.to!int;
    foreach (_; 0..M) {
        auto s = readln.split.map!(to!int);
        auto a = s[0];
        auto b = s[1] - 1;
        auto c = s[2] - 1;
        if (a == 0) {
            U[b][c] = true;
            T[b] -= S[c];
        }
        else if (U[b][c]) {
            writeln(S[c], " ", S[c]);
        }
        else {
            int unknown = U[b].count(false).to!int - 1;
            int minp = max(0, T[b] - unknown * 100);
            int maxp = min(100, T[b]);
            writeln(minp, " ", maxp);
        }

    }
}
