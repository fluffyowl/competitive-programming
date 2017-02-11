import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

void main() {
    alias Tuple!(int, "p", int, "u") oyatsu;
    int N, P, a, b;
    scanf("%d %d", &N, &P);
    auto A = new oyatsu[](N);
    foreach (i; 0..N) {
        scanf("%d %d", &a, &b);
        A[i] = oyatsu(a, b);
    }

    A.sort!"a > b"();

    auto ans = A[0].u;
    auto dp = new int[][](N, P+1);

    foreach (j; 0..P+1)
        if (A[0].p <= j)
            dp[0][j] = A[0].u;

    foreach (i; 1..N) {
        foreach (j; 0..P+1) {
            ans = max(ans, dp[i-1][j]+A[i].u);
            if (j + A[i].p <= P)
                dp[i][j+A[i].p] = max(dp[i-1][j+A[i].p], dp[i-1][j] + A[i].u);

        }
    }

    ans.writeln;
}
