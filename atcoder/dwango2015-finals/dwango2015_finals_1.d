import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    immutable long MOD = 10^^9 + 7;
    
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto X = s[1];
    auto S = readln.chomp;

    auto dp = new long[][][][](2, 3, N+1, X+1);
    dp[0][0][0][0] = 1;
    int cur = 0, tar = 1;

    foreach (i; 0..N) {
        foreach (j; 0..3) foreach (k; 0..N) dp[tar][j][k].fill(0);
        foreach (j; 0..3) {
            foreach (k; 0..N) {
                foreach (l; 0..X+1) {
                    if (S[i] == '2' || S[i] == '?') {
                        if (j == 2) {
                            dp[tar][1][k][l] += dp[cur][j][k][l];
                            dp[tar][1][k][l] %= MOD;
                        } else {
                            dp[tar][1][0][l] += dp[cur][j][k][l];
                            dp[tar][1][0][l] %= MOD;
                        }
                    }
                    if (S[i] == '5' || S[i] == '?') {
                        if (j == 1) {
                            dp[tar][2][k+1][min(X, l+k+1)] += dp[cur][j][k][l];
                            dp[tar][2][k+1][min(X, l+k+1)] %= MOD;
                        } else {
                            dp[tar][2][0][l] += dp[cur][j][k][l];
                            dp[tar][2][0][l] %= MOD;
                        }
                    }
                    if (S[i] != '2' && S[i] != '5') {
                        dp[tar][0][0][l] += dp[cur][j][k][l] * (S[i] == '?' ? 8 : 1);
                        dp[tar][0][0][l] %= MOD;
                    } 
                } 
            }
        }
        swap(cur, tar);
    }

    long ans = 0;
    foreach (j; 0..3) foreach (k; 0..N+1) (ans += dp[cur][j][k][X]) %= MOD;
    ans.writeln;
}
