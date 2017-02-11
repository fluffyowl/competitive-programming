import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;


void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto Y = s[2];
    auto Z = s[3];
    int[char] C;
    auto P = new int[](M);
    foreach (i; 0..M) {
        auto t = readln.split;
        C[t[0][0]] = i;
        P[i] = t[1].to!int;
    }
    auto B = readln.chomp;

    immutable long NEG_INF = - (1L << 60);
    auto dp = new long[][][](2, M, 2^^M);
    foreach (i; 0..2) foreach (j; 0..M) fill(dp[i][j], NEG_INF);
    foreach (j; 0..M) dp[0][j][0] = 0;
    dp[0][C[B[0]]][(1 << C[B[0]])] = P[C[B[0]]];
    if (M == 1) dp[0][C[B[0]]][(1 << C[B[0]])] += Z;
    auto full = (1 << M) - 1;

    foreach (i; 1..N) {
        foreach (j; 0..M) {
            foreach (k; 0..(1 << M)) {
                auto tar = i % 2;
                auto cur = 1 - tar;
                if (dp[cur][j][k] == NEG_INF) continue;
                auto c = C[B[i]];
                auto p = P[c];
                if (j == c && k != 0) p += Y;
                if (((k | (1 << c)) == full && k != full)) p += Z;
                dp[tar][j][k] = max(dp[cur][j][k], dp[tar][j][k]);
                dp[tar][c][k|(1<<c)] = max(dp[tar][c][k|(1<<c)],
                                           dp[cur][j][k] + p);
            }
        }
    }

    long ans = 0;
    foreach (j; 0..M)
        foreach (k; 0..(1 << M))
            ans = max(ans, dp[1-N%2][j][k]);
    ans.writeln;
    
}
