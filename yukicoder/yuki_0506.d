import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

immutable int MOD = 10^^9+7;
alias Tuple!(int, "r", int, "c", string, "name") Friend;


void main() {
    auto s = readln.split.map!(to!int);
    auto H = s[0];
    auto W = s[1];
    auto K = s[2];
    auto P = s[3];
    auto F = new Friend[](K);
    foreach (i; 0..K) {
        auto t = readln.split;
        F[i] = Friend(t[0].to!int, t[1].to!int, t[2]);
    }

    BigInt maxval = 0;
    int maxf = 0;
    foreach (i; 0..2^^K) {
        if (i.popcnt != P) continue;
        auto B = new bool[][](H+1, W+1);
        foreach (j; 0..K) {
            if (!(i & (1 << j))) {
                B[F[j].r][F[j].c] = true;
            }
        }

        auto dp = new BigInt[][](H+1, W+1);
        dp[0][0] = 1;
        foreach (r; 0..H+1) {
            foreach (c; 0..W+1) {
                if (B[r][c]) continue;
                if (r > 0) dp[r][c] = (dp[r][c] + dp[r-1][c]);
                if (c > 0) dp[r][c] = (dp[r][c] + dp[r][c-1]);
            }
        }

        if (dp[H][W] > maxval) {
            maxval = dp[H][W];
            maxf = i;
        }
    }

    if (maxval == 0) {
        writeln(0);
    }
    else {
        writeln(maxval % MOD);
        foreach (i; 0..K) {
            if (maxf & (1 << i)) writeln(F[i].name);
        }
    }
}

