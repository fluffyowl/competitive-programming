import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

int N, MAX_W;
int[] V, W;

void solve1() {
    alias Tuple!(int, "b", long, "w", long, "v") node;

    auto m1 = 1 << (N/2);
    auto n1 = new node[](m1);

    foreach (i; 0..m1) {
        n1[i] = node(i, 0, 0);
        foreach (j; 0..N/2) {
            if (i & (1 << j)) {
                n1[i].w += W[j];
                n1[i].v += V[j];
            }
        }
    }

    auto m2 = 1 << (N/2 + N%2);
    auto n2 = new node[](m2);

    foreach (i; 0..m2) {
        n2[i] = node(i, 0, 0);
        foreach (j; 0..N/2+N%2) {
            if (i & (1 << j)) {
                n2[i].w += W[j+N/2];
                n2[i].v += V[j+N/2];
            }
        }
    }

    n1.sort!"a.w < b.w"();
    n2.sort!"a.w < b.w"();

    foreach (i; 1..m1)
        n1[i].v = max(n1[i].v, n1[i-1].v);
    foreach (i; 1..m2)
        n2[i].v = max(n2[i].v, n2[i-1].v);

    long ans = 0;
    foreach (i; 0..m1) {
        if (MAX_W - n1[i].w < 0)
            continue;
        int hi = m2;
        int lo = 0;
        while (hi - lo > 1) {
            int mid = (hi + lo) / 2;
            if (n1[i].w + n2[mid].w <= MAX_W)
                lo = mid;
            else
                hi = mid;
        }
        ans = max(ans, n1[i].v + n2[lo].v);
    }

    ans.writeln;
}

void solve2() {
    MAX_W = min(MAX_W, N * 1000);
    auto dp = new long[][](N, MAX_W+1);

    foreach (i; 0..MAX_W+1)
        dp[0][i] = (W[0] == i) ? V[0] : 0;

    foreach (i; 1..N) {
        foreach (j; 0..MAX_W+1) {
            dp[i][j] = dp[i-1][j];
            if (j - W[i] >= 0 && j - W[i] <= MAX_W)
                dp[i][j] = max(dp[i][j], dp[i-1][j-W[i]] + V[i]);
        }
    }

    dp[N-1].reduce!(max).writeln;
}

void solve3() {
    immutable long INF = 10L^^15;
    int MAX_V = V.sum + 1;

    auto dp = new long[][](N, MAX_V);

    foreach (i; 0..MAX_V)
        dp[0][i] = (V[0] == i) ? W[0] : INF;
    dp[0][0] = 0;

    foreach (i; 1..N) {
        foreach (j; 0..MAX_V) {
            dp[i][j] = dp[i-1][j];
            if (j - V[i] >= 0 && j - V[i] < MAX_V) {
                dp[i][j] = min(dp[i][j], dp[i-1][j-V[i]] + W[i]);
            }
        }
    }

    for (int i = MAX_V-1; i >= 0; i--) {
        if (dp[N-1][i] <= MAX_W) {
            writeln(i);
            return;
        }
    }
    writeln(0);
}

void main() {
    scanf("%d %d", &N, &MAX_W);
    V = new int[](N);
    W = new int[](N);
    foreach (i; 0..N) scanf("%d %d", &V[i], &W[i]);

    if (N <= 30)
        solve1;
    else if (W.reduce!(max) <= 1000)
        solve2;
    else
        solve3;

}
