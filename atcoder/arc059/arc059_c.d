import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;


immutable int MOD = 10^^9+7;
immutable int MAX = 401;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto K = s[1];
    auto A = readln.split.map!(to!long).array;
    auto B = readln.split.map!(to!long).array;

    auto p = new long[][](MAX, MAX);
    foreach (i; 0..MAX) {
        p[i][0] = 1;
        foreach (j; 1..MAX) {
            p[i][j] = p[i][j-1] * i % MOD;
        }
    }

    auto ps = new long[][](MAX, MAX+1);
    foreach (i; 0..MAX) {
        ps[i][0] = 1;
        foreach (j; 1..MAX) {
            ps[i][j] = (ps[i][j-1] + p[j][i]) % MOD;
        }
    }

    auto dp = new long[][](N+1, K+1);
    foreach (i; 0..N+1) fill(dp[i], 0);
    dp[0][0] = 1;

    foreach (i; 1..N+1) {
        foreach (j; 0..K+1) {
            foreach (k; 0..j+1) {
                auto wa = ps[j-k][B[i-1].to!int] - ps[j-k][A[i-1].to!int-1];
                dp[i][j] += dp[i-1][k] * wa % MOD;
                dp[i][j] %= MOD;
            }
        }
    }

    //dp.writeln;
    writeln((dp[N][K]+MOD)%MOD);
}
