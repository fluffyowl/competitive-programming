import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long MOD = 10^^9 + 7;

bool valid(int mask) {
    while (mask > 0) {
        if ((mask & 0b11) == 0b11) {
            return false;
        }
        mask >>= 1;
    }
    return true;
}

void main() {
    auto s = readln.split.map!(to!int);
    auto H = s[0];
    auto W = s[1];
    auto K = s[2] - 1;

    auto dp = new int[][](H+1, W);
    dp[0][0] = 1;

    auto masks = (1<<(W-1)).iota.filter!(a => valid(a)).array;

    foreach (i; 0..H) {
        foreach (j; 0..W) {
            foreach (mask; masks) {
                if (j > 0 && (mask & (1 << (j - 1)))) {
                    (dp[i+1][j-1] += dp[i][j]) %= MOD;
                } else if (j < W - 1 && (mask & (1 << j))) {
                    (dp[i+1][j+1] += dp[i][j]) %= MOD;
                } else {
                    (dp[i+1][j] += dp[i][j]) %= MOD;
                }
            }
        }
    }

    dp[H][K].writeln;
}
