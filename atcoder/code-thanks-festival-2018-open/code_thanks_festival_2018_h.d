import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable int INF = 1 << 29;

void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!long).array;
    auto B = new long[](N+1);
    foreach (i; 0..N) B[i+1] = B[i] + A[i];

    bool canAliceWin(long x) {
        auto dp = new int[][](2, N+1);
        foreach (i; 0..2) foreach (j; 0..N+1) dp[i][j] = i == 0 ? -INF : INF;

        int dfs(int t, int n) {
            if (abs(dp[t][n]) != INF)
                return dp[t][n];
            if (n == N)
                return 0;

            foreach (m; n..N) {
                if (t == 0)
                    dp[t][n] = max(dp[t][n], dfs(t^1, m+1) + (B[m+1] - B[n] >= x ? 1 : -1));
                else
                    dp[t][n] = min(dp[t][n], dfs(t^1, m+1) + (B[m+1] - B[n] >= x ? 1 : -1));
            }

            return dp[t][n];
        }

        return dfs(0, 0) >= 0;
    }

    long hi = 1L << 59;
    long lo = -hi;

    while (hi - lo > 1) {
        long mid = (hi + lo) / 2;
        (canAliceWin(mid) ? lo : hi) = mid;
    }

    lo.writeln;
}
