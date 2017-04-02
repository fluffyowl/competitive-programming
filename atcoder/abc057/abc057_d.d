import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;

alias Tuple!(long, "v", long, "cnt") V;
real EPS = 0.0000000000001;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto A = s[1];
    auto B = s[2];
    auto v = readln.split.map!(to!long).array;

    auto dp = new V[][](N+1, N+1); // i個目まで見てj個取ったときの最大値
    foreach (i; 0..N+1) fill(dp[i], V(0, 0));
    dp[0][0] = V(0, 1);
    foreach (i; 0..N) {
        dp[i+1] = dp[i].dup;
        foreach (j; 0..i+1) {
            long next_v = dp[i][j].v + v[i];
            if (next_v > dp[i+1][j+1].v) dp[i+1][j+1] = V(next_v, dp[i][j].cnt);
            else if (next_v == dp[i+1][j+1].v) {
                dp[i+1][j+1].cnt += dp[i][j].cnt;
            }
        }
    }

    long ans_v = 0;
    long ans_bunbo = 1;
    long ans_cnt = 0;
    foreach (j; A..B+1) {
        if (dp[N][j].cnt == 0) continue;
        long g = gcd(dp[N][j].v, j);
        long new_v = dp[N][j].v / g;
        long new_j = j / g;
        if (new_v * ans_bunbo > ans_v * new_j) {
            ans_v = new_v;
            ans_bunbo = new_j;
            ans_cnt = dp[N][j].cnt;
        }
        else if (new_v * ans_bunbo == ans_v * new_j) {
            ans_cnt += dp[N][j].cnt;
        }
    }

    writefln("%.8f", 1.0 * ans_v / ans_bunbo);
    writeln(ans_cnt);
}
