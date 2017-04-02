import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;

immutable int MOD = 10^^9+7;
int[800][2][3][2][2] dp;

int solve(ref string N, int P, bool less) {
    auto M = N.length;

    memset(dp[0].ptr, 0, dp[0].sizeof);
    dp[0][0][0][0][0] = 1;
    int cur, tar, dig;

    foreach (a; 0..M) {
        cur = a % 2;
        tar = 1 - cur;
        dig = N[a]-'0';
        memset(dp[tar].ptr, 0, dp[tar].sizeof);
        foreach (b; 0..2) {
            int digit = b ? 10 : dig+1;
            foreach (c; 0..3) {
                foreach (d; 0..2) {
                    if (M - a < 6) {
                        foreach (e; 0..P) {
                            foreach (f; 0..digit) {
                                dp[tar][b||(f<dig)][(c+f)%3][d||(f==3)][(10*e+f)%P] +=
                                    dp[cur][b][c][d][e];
                                dp[tar][b||(f<dig)][(c+f)%3][d||(f==3)][(10*e+f)%P] %= MOD;
                            }
                        }
                    }
                    else {
                        foreach (f; 0..digit) {
                            dp[tar][b||(f<dig)][(c+f)%3][d||(f==3)][0] +=
                                dp[cur][b][c][d][0];
                            dp[tar][b||(f<dig)][(c+f)%3][d||(f==3)][0] %= MOD;
                        }
                    }
                }
            }
        }
    }

    int ret = 0;
    foreach (a; 0..2) {
        if (less && (a == 0)) continue;
        foreach (b; 0..3) {
            foreach (c; 0..2) {
                foreach (d; 1..P) {
                    if (b == 0 || c == 1) {
                        ret += dp[M%2][a][b][c][d];
                        ret %= MOD;
                    }
                }
            }
        }
    }

    return ret;
}

void main() {
    auto s = readln.split;
    auto A = s[0];
    auto B = s[1];
    auto P = s[2].to!int;

    auto a = solve(A, P, true);
    auto b = solve(B, P, false);
    auto ans = (b - a) % MOD;
    ans = (ans + MOD) % MOD;

    ans.writeln;
}

