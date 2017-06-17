import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;//, core.stdc.stdio;

alias Tuple!(int, "l", int, "r", int, "x") Condition;
immutable int MOD = 10^^9 + 7;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto C = new Condition[][](N+1);
    foreach (i; 0..M) {
        s = readln.split.map!(to!int);
        C[s[1]] ~= Condition(s[0], s[1], s[2]);
    }

    auto dp = new int[][][](N+1, N+1, N+1);
    dp[0][0][0] = 1;
    
    foreach (i; 0..N) {
        foreach (j; 0..N) {
            foreach (k; 0..N) {
                int mx = max(i, max(j, k));
                (dp[mx+1][j][k] += dp[i][j][k]) %= MOD;
                (dp[i][mx+1][k] += dp[i][j][k]) %= MOD;
                (dp[i][j][mx+1] += dp[i][j][k]) %= MOD;
                foreach (c; C[mx+1]) {
                    if (c.x == 1) {
                        if (j >= c.l || k >= c.l) dp[mx+1][j][k] = 0;
                        if (k >= c.l || i >= c.l) dp[i][mx+1][k] = 0;
                        if (i >= c.l || j >= c.l) dp[i][j][mx+1] = 0;
                    } else if (c.x == 2) {
                        if (j <  c.l && k <  c.l) dp[mx+1][j][k] = 0;
                        if (j >= c.l && k >= c.l) dp[mx+1][j][k] = 0;
                        if (k <  c.l && i <  c.l) dp[i][mx+1][k] = 0;
                        if (k >= c.l && i >= c.l) dp[i][mx+1][k] = 0;
                        if (i <  c.l && j <  c.l) dp[i][j][mx+1] = 0;
                        if (i >= c.l && j >= c.l) dp[i][j][mx+1] = 0;
                    } else {
                        if (j < c.l || k < c.l) dp[mx+1][j][k] = 0;
                        if (k < c.l || i < c.l) dp[i][mx+1][k] = 0;
                        if (i < c.l || j < c.l) dp[i][j][mx+1] = 0;
                    }
                }
            }
        }
    }


    
    int ans = 0;
    
    foreach (i; 0..N+1) {
        foreach (j; 0..N+1) {
            if (dp[i][j][N] != -1) (ans += dp[i][j][N]) %= MOD;
            if (dp[i][N][j] != -1) (ans += dp[i][N][j]) %= MOD;
            if (dp[N][i][j] != -1) (ans += dp[N][i][j]) %= MOD;
        }
    }

    ans.writeln;
}
