import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

immutable long MOD = 100000009;
long[] primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31];

void solve() {
    auto s = readln.split.map!(to!long);
    auto seed = s[0];
    auto N = s[1].to!int;
    auto K = s[2].to!int;
    auto B = s[3];

    auto A = new long[](N+1);
    A[0] = seed;
    foreach (i; 0..N) {
        A[i+1] = 1 + ((A[i] * A[i] % MOD + A[i] * 12345 % MOD)) % MOD;
    }


    long ans = 1 << 29;
    foreach (p; primes) {
        if (B % p != 0) continue;
        auto cnt = new long[](N+1);
        fill(cnt, 0);
        foreach (i; 0..N+1) {
            long a = A[i];
            while (a % p == 0) cnt[i]++, a/=p;
        }
        cnt.sort();
        long b = B;
        long d = 0;
        while (b % p == 0) d++, b/=p;
        ans = min(ans, cnt[0..K].sum / d);
    }
    
    ans.writeln;
}

void main() {
    auto Q = readln.chomp.to!int;
    while (Q--) solve;
}

