import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto s = readln.split.map!(to!long);
    auto B = s[0];
    auto C = s[1];
    auto D = s[2];
    immutable long MOD = 10^^9 + 7;
    if (C == 1) {
        writeln(B % MOD * (D % MOD) % MOD);
        return;
    }
    long ans = powmod(C%MOD, D+1, MOD) - 1;
    ans = (ans + MOD) % MOD;
    ans = ans * powmod((C-1)%MOD, MOD-2, MOD) % MOD;
    ans = (ans % MOD - 1 + MOD) % MOD;
    ans = B % MOD * ans % MOD;
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

