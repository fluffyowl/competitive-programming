import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

immutable long MOD = 10^^9+7;

long powmod(long a, long x, long m) {
    a %= m;
    long ret = 1;
    while (x) {
        if (x % 2) ret = ret * a % m;
        a = a * a % m;
        x /= 2;
    }
    return ret;
}

void main() {
    long N = readln.chomp.to!long;
    
    long a = powmod(100, N, MOD) - 1;
    long b = powmod(99, MOD-2, MOD);
    a = (a + MOD) % MOD;
    writeln(a * b % MOD);

    long c = N % 11;
    string s = "";
    foreach (i; 0..c) s ~= "01";
    writeln(s.length == 0 ? "0" : s[1..$]);
}

