import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto N = readln.chomp.to!long;
    long C = N;
    long ans = 0;
    long MOD = 10^^9+7;

    foreach (i; 1..N+1) {
        ans = ans + C * powmod(i, N - i, MOD);
        ans %= MOD;
        C = C * (N - i) % MOD * powmod(i + 1, MOD - 2, MOD) % MOD;
    }

    ans.writeln;
}

long powmod(long a, long x, long m) {
    long ret = 1;
    while (x) {
        if (x % 2) ret = ret * a % m;
        a = a * a % m;
        x /= 2;
    }
    return ret;
}

