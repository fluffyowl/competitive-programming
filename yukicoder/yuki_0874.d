import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

void main() {
    auto S = readln.chomp;
    auto T = readln.chomp;
    string s, t;
    int[] sx, tx;
    foreach (c; S) {
        if (c == '?') sx.back = 1;
        else if (c == '*') sx.back = 2;
        else s ~= c, sx ~= 0;
    }
    foreach (c; T) {
        if (c == '?') tx.back = 1;
        else if (c == '*') tx.back = 2;
        else t ~= c, tx ~= 0;
    }
    auto n = s.length.to!int;
    auto m = t.length.to!int;

    auto dp = new int[][](n + 1, m + 1);
    foreach (i; 0..n+1) dp[i][] = 1 << 29;
    dp[0][0] = 0;

    foreach (i; 0..n+1) {
        foreach (j; 0..m+1) {
            if (i == n && j == m) {
                continue;
            }
            if (i == n) {
                dp[i][j+1] = min(dp[i][j+1], dp[i][j] + (tx[j] == 0));
                continue;
            }
            if (j == m) {
                dp[i+1][j] = min(dp[i+1][j], dp[i][j] + (sx[i] == 0));
                continue;
            }

            if (sx[i] == 2 && tx[j] == 2) {
                dp[i+1][j+1] = min(dp[i+1][j+1], dp[i][j]);
                dp[i+1][j] = min(dp[i+1][j], dp[i][j]);
                dp[i][j+1] = min(dp[i][j+1], dp[i][j]);
            } else if (sx[i] == 2) {
                dp[i+1][j] = min(dp[i+1][j], dp[i][j]);
                if (s[i] == t[j]) {
                    dp[i+1][j+1] = min(dp[i+1][j+1], dp[i][j]);
                    dp[i][j+1] = min(dp[i][j+1], dp[i][j]);
                }
            } else if (tx[j] == 2) {
                dp[i][j+1] = min(dp[i][j+1], dp[i][j]);
                if (s[i] == t[j]) {
                    dp[i+1][j+1] = min(dp[i+1][j+1], dp[i][j]);
                    dp[i+1][j] = min(dp[i+1][j], dp[i][j]);
                }
            }

            if (sx[i] == 1 && tx[j] == 1) {
                dp[i+1][j+1] = min(dp[i+1][j+1], dp[i][j]);
                dp[i+1][j] = min(dp[i+1][j], dp[i][j]);
                dp[i][j+1] = min(dp[i][j+1], dp[i][j]);
            } else if (sx[i] == 1) {
                dp[i+1][j] = min(dp[i+1][j], dp[i][j]);
                if (s[i] == t[j]) {
                    dp[i+1][j+1] = min(dp[i+1][j+1], dp[i][j]);
                }
            } else if (tx[j] == 1) {
                dp[i][j+1] = min(dp[i][j+1], dp[i][j]);
                if (s[i] == t[j]) {
                    dp[i+1][j+1] = min(dp[i+1][j+1], dp[i][j]);
                }
            }

            if (s[i] == t[j]) {
                dp[i+1][j+1] = min(dp[i+1][j+1], dp[i][j]);
            }

            dp[i+1][j] = min(dp[i+1][j], dp[i][j] + 1);
            dp[i][j+1] = min(dp[i][j+1], dp[i][j] + 1);
            dp[i+1][j+1] = min(dp[i+1][j+1], dp[i][j] + 1);
        }
    }

    dp[n][m].writeln;
}

