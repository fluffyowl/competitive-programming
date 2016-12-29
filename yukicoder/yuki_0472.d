import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

void main() {
    int N, P;
    scanf("%d %d", &N, &P);

    auto A = new int[][](N, 4);
    foreach (i; 0..N) {
        scanf("%d %d %d", &A[i][0], &A[i][1], &A[i][2]);
        A[i][3] = 1;
    }

    auto dp = new int[][](2, P+1);
    foreach (j; 0..P+1)
        dp[0][j] = A[0][min(j, 3)];

    foreach (i; 1..N) {
        foreach (j; 0..P+1) {
            int k = i % 2;
            dp[k][j] = dp[1-k][j] + A[i][0];
            if (j >= 1) dp[k][j] = min(dp[k][j], dp[1-k][j-1] + A[i][1]);
            if (j >= 2) dp[k][j] = min(dp[k][j], dp[1-k][j-2] + A[i][2]);
            if (j >= 3) dp[k][j] = min(dp[k][j], dp[1-k][j-3] + A[i][3]);
        }
    }

    writefln("%.10f", dp[1-N%2][P] * 1.0L / N);
}

