import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip, std.regex;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto A = N.iota.map!(_ => readln.chomp.to!long).array;
    auto cnt = new long[](10^^5+1);

    foreach (a; A) {
        for (long x = 1; x * x <= a; ++x) {
            if (a % x) continue;
            cnt[x] += 1;
            if (x * x != a) cnt[a/x] += 1;
        }
    }

    for (long n = 1; n <= M; ++n) {
        if (n == 1) {
            N.writeln;
            continue;
        }

        long[] P;
        long nn = n;
        for (long p = 2; p * p <= n && nn > 1; ++p) {
            if (nn % p == 0) P ~= p;
            while (nn % p == 0) nn /= p;
        }
        if (nn > 1) P ~= nn;

        long ans = 0;
        foreach (mask; 1..(1<<P.length)) {
            long x = 1;
            foreach (i; 0..P.length) if ((mask >> i) & 1) x *= P[i];
            if (mask.popcnt % 2) ans += cnt[x];
            else ans -= cnt[x];
        }

        writeln(N-ans);
    }
}
