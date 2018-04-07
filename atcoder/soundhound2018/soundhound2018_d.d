import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

const long MOD = 10^^9 + 7;

void main() {
    auto s = readln.split.map!(to!int);
    auto H = s[0];
    auto W = s[1];
    auto P = H.iota.map!(_ => readln.split.map!(to!long).array).array;
    auto F = H.iota.map!(_ => readln.split.map!(to!long).array).array;
    auto PF = H.iota.map!(i => W.iota.map!(j => P[i][j] - F[i][j]));

    auto dpdp1 = new long[][](H, W);
    auto dpdp2 = new long[][](H, W);

    foreach (i; 0..H) {
        for (int j = 1; j < W; ++j) {
            dpdp1[i][j] = dpdp1[i][j-1] + P[i][j-1] - F[i][j-1] - F[i][j];
            if (dpdp1[i][j] < 0) dpdp1[i][j] = 0;
        }

        for (int j = W-2; j >= 0; --j) {
            dpdp2[i][j] = dpdp2[i][j+1] + P[i][j+1] - F[i][j+1] - F[i][j];
            if (dpdp2[i][j] < 0) dpdp2[i][j] = 0;
        }
    }


    auto dp = new long[][](H, W);
    auto dp1 = new long[][](H, W);
    auto dp2 = new long[][](H, W);
    foreach (i; 0..H) dp[i].fill(-(1L<<59));
    foreach (i; 0..H) dp1[i].fill(-(1L<<59));
    foreach (i; 0..H) dp2[i].fill(-(1L<<59));

    foreach (j; 0..W) {
        if (j == 0) {
            dp[0][j] = PF[0][j];
        } else  {
            dp[0][j] = dp[0][j-1] + PF[0][j];
        }
    }
    foreach (j; 0..W) {
        dp[0][j] += dpdp2[0][j];
    }

    foreach (i; 1..H) {
        foreach (j; 0..W) {
            long left = j > 0 ? dp1[i][j-1] + PF[i][j] : - (1L << 59);
            long up = dp[i-1][j] + PF[i][j];

            up += dpdp1[i][j];
            dp1[i][j] = max(dp1[i][j], left, up);

            left += dpdp2[i][j];
            up += dpdp2[i][j];
            dp[i][j] = max(dp[i][j], left, up);
        }

        for (int j = W-1; j >= 0; --j) {
            long right = j < W - 1 ? dp2[i][j+1] + PF[i][j] : -(1L << 59);
            long up = dp[i-1][j] + PF[i][j];

            up += dpdp2[i][j];
            dp2[i][j] = max(dp2[i][j], right, up);

            right += dpdp1[i][j];
            up += dpdp1[i][j];
            dp[i][j] = max(dp[i][j], up, right);
        }
    }

    W.iota.each!(j => dp[H-1][j].writeln);
}
