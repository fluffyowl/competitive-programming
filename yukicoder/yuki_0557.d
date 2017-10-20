import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

const long MOD = 10^^9+7;

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
    auto N = readln.chomp.to!long;
    long ans = 1;

    if (N == 1) {
        2.writeln;
        return;
    }

    ans = ans * 4 % MOD;
    ans = ans * powmod(5, N/2-1, MOD) % MOD;

    if (N % 2) ans = ans * 3 % MOD;
    ans.writeln;
}

