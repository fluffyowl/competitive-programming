import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;

immutable long MOD = 10^^9 + 7;
long[] F;

void main() {
    auto N = readln.chomp.to!int;
    auto G = new int[][](N);
    foreach (_; 0..N-1) {
        auto s = readln.split.map!(to!int);
        G[s[0]-1] ~= s[1]-1;
        G[s[1]-1] ~= s[0]-1;
    }

    if (N == 1) {
        writeln(1);
        return;
    }

    F = new long[](N+1);
    F[0] = 1;
    foreach (i; 1..N+1) F[i] = F[i-1] * i % MOD;

    long leaves = iota(1, N).map!(i => G[i].length == 1).sum;
    long ans = comb(N-1, leaves-1) * comb(N-2, leaves-1) % MOD * powmod(leaves, MOD-2, MOD) % MOD;
    ans.writeln;
}

long comb(long n, long r) {
    return F[n] * powmod(F[n-r], MOD-2, MOD) % MOD * powmod(F[r], MOD-2, MOD) % MOD;
}

long powmod(long a, long x, long m) {
    long ret = 1;
    while (x) {
        if (x % 2) ret = a * ret % m;
        a = a * a % m;
        x /= 2;
    }
    return ret;
}

