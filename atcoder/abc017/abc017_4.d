import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

int N, M;
int[] f, overlap, mem;
immutable int MOD = 10^^9+7;


void main() {
    auto s = readln.split.map!(to!int);
    N = s[0];
    M = s[1];
    f = N.iota.map!(_ => readln.chomp.to!int).array;

    overlap = new int[](N);
    foreach (i; 0..N) overlap[i] = N;
    auto used = new bool[](M+1);
    used[f[0]] = true;
    int L = 0, R = 1;
    while (R < N) {
        while (used[f[R]]) {
            overlap[L] = R;
            used[f[L]] = false;
            L++;
        }
        used[f[R]] = true;
        R++;
    }

    auto acm = new int[](N+1);
    auto dp = new int[](N+1);
    dp[N] = acm[N] = 0;
    dp[N-1] = acm[N-1] = 1;
    for (int i = N-2; i >= 0; i--) {
        if (overlap[i] == N)
            dp[i] = 1;
        dp[i] = (dp[i] + acm[i+1] - acm[min(overlap[i]+1, N)]) % MOD;
        if (dp[i] < 0) dp[i] += MOD;
        acm[i] = (dp[i] + acm[i+1]) % MOD;
    }

    dp[0].writeln;

}
