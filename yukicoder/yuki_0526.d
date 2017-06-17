import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

immutable long MOD = 10^^9+7;

void main() {
    auto s = readln.split;
    auto N = s[0].to!int;
    auto M = s[1].to!long;

    auto F = new long[](N+1);
    F[0] = 0;
    F[1] = 0;
    F[2] = 1;
    foreach (i; 3..N+1) {
        F[i] = (F[i-1] + F[i-2]) % M;
    }

    F[N].writeln;
}

