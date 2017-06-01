import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;


void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto A = N.iota.map!(_ => readln.chomp.to!int).array;
    auto X = M.iota.map!(_ => readln.chomp.to!int).array;

    long[int] cnt;
    long[int][2] dp;
    foreach (i; 0..N) {
        int cur = i % 2;
        int tar = 1 - cur;
        foreach (k; dp[tar].keys)
            dp[tar].remove(k);
        foreach (j; dp[cur].keys) {
            int k = gcd(A[i], j);
            if (k in dp[tar])
                dp[tar][gcd(A[i], j)] += dp[cur][j];
            else
                dp[tar][gcd(A[i], j)] = dp[cur][j];
        }
        if (A[i] in dp[tar])
            dp[tar][A[i]] += 1;
        else
            dp[tar][A[i]] = 1;

        foreach (x; dp[tar].keys)
            cnt[x] += dp[tar][x];
    }

    
    foreach (x; X) {
        writeln(x in cnt ? cnt[x] : 0);
    }
}
