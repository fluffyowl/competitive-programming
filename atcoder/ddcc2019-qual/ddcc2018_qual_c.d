import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long MOD = 10^^9 + 7;

void main() {
    auto N = readln.chomp.to!long;
    long ans = 0;

    foreach_reverse (i; 1..N+1) {
        long j = N / i;
        long tmp1 = powmod(i, 10, MOD) - powmod(i-1, 10, MOD);
        long tmp2 = powmod(j, 10, MOD);
        long tmp = tmp1 % MOD * tmp2;
        ans = (ans + tmp) % MOD;
    }

    ans = (ans + MOD) % MOD;
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
