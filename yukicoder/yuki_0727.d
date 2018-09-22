import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long MOD = 10^^9 + 7;

void main() {
    auto N = readln.chomp.to!long;
    long a = 1;
    long x = 1;

    foreach (i; 2..N+1) {
        a = (2 * i - 1) * i % MOD * i % MOD;
        x = x * a % MOD;
    }

    x.writeln;
}

