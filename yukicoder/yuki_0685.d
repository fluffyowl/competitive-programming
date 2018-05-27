import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip, std.regex;

void main() {
    immutable long MOD = 10^^9 + 7;
    auto N = readln.chomp.to!long;
    string S = "";
    while (N > 0) {
        if (N % 2) S = "1" ~ S;
        else S = "0" ~ S;
        N /= 2;
    }

    auto dp = new long[][][][](S.length+1, 2, 2, 2); // 未満フラグ, 最上位ビットが立った, どこかのビットが両方1
    dp[0][0][0][0] = 1;

    foreach (a; 0..S.length.to!int) {
        foreach (b; 0..2) {
            foreach (c; 0..2) {
                foreach (d; 0..2) {
                    foreach (i; 0..2) {
                        foreach (j; 0..2) {
                            if (!b && (S[a] - '0' < i)) continue;
                            if (!c && (j == 1)) continue;
                            int nb = b || (S[a] - '0' > i);
                            int nc = c || (i > j);
                            int nd = d || (i == 1 && j == 1);
                            //writeln([a, b, c, d, i, j, dp[a][b][c][d], nb, nc, nd]);
                            (dp[a+1][nb][nc][nd] += dp[a][b][c][d]) %= MOD;
                        }
                    }
                }
            }
        }
    }

    long ans = 0;
    foreach (i; 0..2) ans += dp[S.length][i][1][1];
    ans %= MOD;
    ans.writeln;
}

