import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

long dp(long n) {
    auto s = n.to!string;
    auto m = s.length.to!int;

    auto dp = new long[][][][][](m+1, 2, 2, 10, 10);
    foreach (a; 0..m+1)
        foreach (b; 0..2)
            foreach (c; 0..2)
                foreach (d; 0..10)
                    foreach (e; 0..10)
                        dp[a][b][c][d][e] = 0;
    dp[0][0][0][0][0] = 1;

    foreach (a; 0..m) {
        foreach (b; 0..2) {
            foreach (c; 0..2) {
                foreach (d; 0..10) {
                    foreach (e; 0..10) {
                        auto new_c = c || (d > 0);
                        if (c && d == e) continue;
                        int start = 0;
                        int end = b ? 9 : s[a] - '0';
                        if (new_c && d < e) end = min(end, e-1);
                        if (new_c && d > e) start = max(start, e+1);
                        foreach (digit; start..end+1) {
                            if (c && digit == d) continue;
                            //if (new_c && digit == d) continue;
                            if (!c && digit == d && d > 0) continue;
                            if (!c && digit == e && d > 0) continue;
                            if (!c && digit == e && e > 0) continue;
                            auto new_b = b || (digit < s[a]-'0');
                            auto new_d = e;
                            auto new_e = digit;
                            //if(dp[a][b][c][d][e]) {
                            //    writeln(a, " ", b, " ", c, " ", d, " ", e ," ", digit);
                            //    writeln(a+1, " ", new_b, " ", new_c, " ", new_d, " ", new_e);
                            //}
                            dp[a+1][new_b][new_c][new_d][new_e] +=
                                dp[a][b][c][d][e];
                        }
                    }
                }
            }
        }
    }

    long ret = 0;
    foreach (b; 0..2) {
        foreach (d; 0..10) {
            foreach (e; 0..10) {
                ret += dp[m][b][1][d][e];
            }
        }
    }

    return ret;
}
void main() {
    auto N = readln.chomp.to!int;
    foreach (i; 0..N) {
        auto T = readln.chomp.to!long;
        long hi = 37294859064823;
        long lo = -1;
        while (hi - lo > 1) {
            auto mid = (hi + lo) / 2;
            if (dp(mid) >= T) hi = mid;
            else lo = mid;
        }
        hi.writeln;
    }
}

