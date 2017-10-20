import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;


void main() {
    const long MOD = 10^^9 + 7;
    auto N = readln.chomp.to!long;
    long x1 = 1;
    long x2 = 0;

    if (N == 1) {
        1.writeln;
        return;
    }

    foreach (i; 2..N) {
        if (i % 2 == 0)
            (x2 += x1 * i % MOD) %= MOD;
        else
            (x1 += x2 * i % MOD) %= MOD;
    }

    writeln(N % 2 ? x2 * N % MOD : x1 * N % MOD);
}

