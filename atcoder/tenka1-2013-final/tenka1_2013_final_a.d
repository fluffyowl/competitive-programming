import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long MOD = 10^^9 + 7;

bool valid(int mask) {
    foreach (i; 0..15) {
        if (((mask >> i) & 1) & ((mask >> (i+1)) & 1)) {
            return false;
        }
    }
    return true;
}

bool valid2(int mask1, int mask2) {
    foreach (i; 0..15) {
        if (((mask1 >> i) & 1) & ((mask2 >> (i+1)) & 1)) {
            return false;
        }
        if (((mask1 >> i) & 1) & ((mask2 >> i) & 1)) {
            return false;
        }
        if (((mask1 >> (i+1)) & 1) & ((mask2 >> i) & 1)) {
            return false;
        }
    }
    return true;
}

void main() {
    auto s = readln.split.map!(to!int);
    auto H = s[0];
    auto W = s[1];
    auto masks = iota(1<<W).filter!(a => valid(a)).array;

    auto dp = new long[][](H+1, 1<<W);
    dp[0][0] = 1;

    foreach (r; 0..H) {
        foreach (mask1; masks) {
            if (dp[r][mask1] == 0) continue;
            foreach (mask2; masks) {
                if (!valid2(mask1, mask2)) continue;
                dp[r+1][mask2] += dp[r][mask1];
                dp[r+1][mask2] %= MOD;
            }
        }
    }

    auto ans = (dp[H].sum - 1) % MOD;
    ans.writeln;
}
