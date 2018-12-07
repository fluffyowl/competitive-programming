import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long MOD = 10^^9 + 7;

void main() {
    auto s = readln.split.map!(to!long);
    auto N = s[0];
    auto M = s[1];
    auto S = readln.chomp;
    auto T = readln.chomp;

    auto L = N * M / gcd(N, M);
    char[long] X;

    long p = 0;
    long a = L / N;
    foreach (i; 0..N) {
        if (p in X) {
            if (X[p] != S[i]) {
                writeln(-1);
                return;
            }
        }
        X[p] = S[i];
        p += a;
    }

    p = 0;
    a = L / M;
    foreach (i; 0..M) {
        if (p in X) {
            if (X[p] != T[i]) {
                writeln(-1);
                return;
            }
        }
        X[p] = T[i];
        p += a;
    }

    writeln(L);
}
