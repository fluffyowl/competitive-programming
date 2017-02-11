import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio, std.bitmanip;

immutable long INF = 1L << 60;
immutable int T_MAX = 10^^5+1;
int W, H, Q, t, d, x;
auto B = new int[][][](2, T_MAX);

long solve(int d) {
    auto WH = d == 0 ? W : H;
    auto dp = new long[](WH);
    fill(dp, 0);

    foreach (i; 1..T_MAX) {
        sort(B[d][i]);
        foreach (b; B[d][i]) {
            if (b+1 < WH) dp[b+1] = min(dp[b+1], dp[b] + 1);
        }
        reverse(B[d][i]);
        foreach (b; B[d][i]) {
            if (b-1 >= 0) dp[b-1] = min(dp[b-1], dp[b] + 1);
        }
        foreach (b; B[d][i]) {
            dp[b] = INF;
        }

    }

    return dp.reduce!(min);

}

void main() {
    scanf("%d %d %d", &W, &H, &Q);
    foreach (i; 0..Q) {
        scanf("%d %d %d", &t, &d, &x);
        B[d][t] ~= x-1;
    }

    auto ans = solve(0) + solve(1);
    writeln(ans >= INF ? -1 : ans);
}
