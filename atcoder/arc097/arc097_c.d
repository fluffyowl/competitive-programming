import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip, std.regex;

void main() {
    immutable int INF = 1 << 29;

    auto N = readln.chomp.to!int;
    auto A = new int[](2*N);
    auto C = new bool[](2*N);
    foreach (i; 0..2*N) {
        auto s = readln.split;
        A[i] = s[1].to!int;
        C[i] = s[0] == "B";
    }

    auto BR = new int[](N+1);
    auto WR = new int[](N+1);
    foreach (i; 0..2*N) {
        if (C[i]) BR[A[i]] = i;
        else      WR[A[i]] = i;
    }

    auto dpB = new int[][](N+1, 2*N+1); //座標iまでで、jより大きいBの数
    auto dpW = new int[][](N+1, 2*N+1); //座標iまでで、jより大きいWの数

    foreach (i; 0..N+1) foreach (j; 0..2*N) dpB[i][j+1] = dpB[i][j] + (C[j] && A[j] > i);
    foreach (i; 0..N+1) foreach (j; 0..2*N) dpW[i][j+1] = dpW[i][j] + (!C[j] && A[j] > i);

    auto dp = new int[][](N+1, N+1);
    foreach (i; 0..N+1) dp[i].fill(INF);
    dp[0][0] = 0;

    foreach (n; 1..2*N+1) {
        foreach (b; 0..n+1) {
            int w = n - b;
            if (b > N || w > N) continue;
            stdout.flush;
            if (b > 0) {
                dp[b][w] = min(dp[b][w], dp[b-1][w] + dpB[b][BR[b]+1] + dpW[w][BR[b]+1]);
            }
            if (w > 0) {
                dp[b][w] = min(dp[b][w], dp[b][w-1] + dpW[w][WR[w]+1] + dpB[b][WR[w]+1]);
            }
        }
    }

    dp[N][N].writeln;
}
