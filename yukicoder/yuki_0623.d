import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

immutable long MOD = 998244353;

void main() {
    auto N = readln.chomp.to!int;
    auto F = (N-1).iota.map!(_ => readln.split.map!(to!int).array).array;
    auto Q = readln.chomp.to!int;
    auto X = readln.split.map!(to!long).array;

    foreach (x; X) {
        auto Y = new long[](N+1);
        Y[0] = 1;
        Y[1] = x;
        foreach (i, f; F.enumerate) {
            if (f[0] == 1) {
                Y[i+2] = (Y[f[1]] + Y[f[2]]) % MOD;
            } else if (f[0] == 2) {
                Y[i+2] = (f[1] * Y[f[2]]) % MOD;
            } else {
                Y[i+2] = Y[f[1]] * Y[f[2]] % MOD;
            }
        }
        Y.back.writeln;
    }
}

