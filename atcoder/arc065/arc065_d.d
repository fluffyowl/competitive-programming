import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long MOD = 10^^9 + 7;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto S = readln.chomp;
    auto LR = M.iota.map!(_ => readln.split.map!(a => a.to!int - 1).array).array;

    auto zeros = new long[](N+1);
    foreach (i; 0..N) {
        zeros[i+1] = zeros[i] + (S[i] == '0');
    }

    auto dp = new long[][](N+1, N+1);
    dp[0][0] = 1;
    int rmax = 0;
    int q = 0;

    foreach (i; 0..N) {
        while (q < M && LR[q][0] <= i) {
            rmax = max(LR[q][1], rmax);
            q += 1;
        }
        rmax = max(rmax, i);
        long zero = zeros[rmax+1];
        long one = rmax + 1 - zero;

        foreach (j; 0..i+1) {
            long rest_zero = zero - j;
            long rest_one = one - (i - j);
            if (rest_zero < 0 || rest_one < 0) {
                continue;
            }
            if (rest_zero > 0) {
                dp[i+1][j+1] += dp[i][j];
                dp[i+1][j+1] %= MOD;
            }
            if (rest_one > 0) {
                dp[i+1][j] += dp[i][j];
                dp[i+1][j+1] %= MOD;
            }
        }
    }

    long ans = 0;
    foreach (a; dp[N]) {
        ans += a;
        ans %= MOD;
    }

    ans.writeln;
}
