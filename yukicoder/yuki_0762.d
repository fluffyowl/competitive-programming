import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;

immutable long MOD = 10^^9 + 7;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto S = readln.chomp;
    auto G = new int[][](N);
    foreach (_; 0..M) {
        s = readln.split.map!(to!int);
        G[s[0]-1] ~= s[1]-1;
        G[s[1]-1] ~= s[0]-1;
    }

    auto cnt = new long[](N);

    foreach (i; 0..N)
        if (S[i] == 'D')
            foreach (j; G[i])
                if (S[j] == 'P')
                    ++cnt[i];

    long ans = 0;

    foreach (i; 0..N) {
        if (S[i] == 'C') {
            long p = 0;
            long a = 0;
            foreach (j; G[i]) {
                if (S[j] == 'D') {
                    p += cnt[j];
                } else if (S[j] == 'A') {
                    a += 1;
                }
            }
            ans += p * a % MOD;
            ans %= MOD;
        }
    }

    ans.writeln;
}

