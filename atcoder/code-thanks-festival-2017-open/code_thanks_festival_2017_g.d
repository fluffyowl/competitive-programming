import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto G = new bool[][](N, N);
    foreach (_; 0..M) {
        s = readln.split.map!(to!int);
        G[s[0]-1][s[1]-1] = true;
        G[s[1]-1][s[0]-1] = true;
    }

    void solve(int n, int offset, int[] dp) {
        dp[0] = 0;
        foreach (mask; 0..(1<<n)) {
            foreach (i; 0..n) {
                dp[mask|(1<<i)] = max(dp[mask|(1<<i)], dp[mask]);
            }
            if (dp[mask] != mask.popcnt) {
                continue;
            }
            foreach (i; 0..n) {
                if (mask & (1 << i)) continue;
                bool ok = true;
                foreach (j; 0..n) {
                    if (!(mask & (1 << j))) continue;
                    if (G[i+offset][j+offset]) {
                        ok = false;
                        break;
                    }
                }
                if (ok) {
                    dp[mask|(1<<i)] = dp[mask] + 1;
                }
            }
        }
    }

    auto X = N / 2;
    auto Y = N / 2 + N % 2;
    auto dp1 = new int[](1<<X);
    auto dp2 = new int[](1<<Y);
    solve(X, 0, dp1);
    solve(Y, X, dp2);
    int ans = 0;

    foreach (mask; 0..(1<<X)) {
        if (dp1[mask] != mask.popcnt) continue;
        int mask2 = (1 << Y) - 1;
        foreach (i; 0..X) {
            if (!(mask & (1 << i))) continue;
            foreach (j; 0..Y) {
                if (G[i][j+X]) {
                    mask2 &= ~(1 << j);
                }
            }
        }
        ans = max(ans, dp1[mask] + dp2[mask2]);
    }

    ans.writeln;
}
