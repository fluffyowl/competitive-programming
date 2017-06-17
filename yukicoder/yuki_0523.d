import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

immutable long MOD = 10^^9 + 7;
immutable long MAX = 10^^7;

long powmod(long a, long x, long m) {
    long ret = 1;
    while (x) {
        if (x % 2) ret = ret * a % m;
        a = a * a % m;
        x /= 2;
    }
    return ret;
}

void main() {
    auto N = readln.chomp.to!int;

    auto F = new long[](MAX*2+1);
    F[0] = F[1] = 1;
    foreach (i; 1..MAX*2) {
        F[i+1] = F[i] * (i + 1) % MOD;
    }

    long ans = F[N * 2] * powmod(powmod(2, MOD-2, MOD), N, MOD) % MOD;
    ans.writeln;
}

