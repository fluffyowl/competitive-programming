import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;


void main() {
    auto s = readln.split.map!(to!long);
    auto KK = s[0];
    auto M = s[1];
    auto MS = M.to!string;

    
    long ans = 0;

    if (KK <= 10^^4) {
        int K = KK.to!int;
        auto L = MS.length;
        auto dp = new long[][][][](L+1, 2, K, 100);
        foreach (i; 0..L+1) foreach (j; 0..2) foreach (k; 0..K) fill(dp[i][j][k], 0);
        dp[0][0][0][0] = 1;

        foreach (a; 0..L) {
            foreach (b; 0..2) {
                foreach (c; 0..K) {
                    foreach (d; 0..100) {
                        auto digits = b ? 10 : MS[a] - '0' + 1;
                        foreach (digit; 0..digits) {
                            auto new_b = b || (digit < MS[a] - '0');
                            auto new_c = (10 * c + digit) % K;
                            auto new_d = (d + digit) % K;
                            if (new_d >= 100) continue;
                            dp[a+1][new_b][new_c][new_d] += dp[a][b][c][d];
                        }
                    }
                }
            }
        }

        foreach (b; 0..2) foreach (c; 0..min(K, 100)) ans += dp[L][b][c][c];
        ans -= 1;
    }
    
    
    else {
        long K = KK;
        for (long i = 0; i < M; i += K) {
            for (long j = 0; j < 100; j++) {
                long k = i + j;
                long S = k.to!string.map!(a => a - '0').sum;
                if (S == j) ans += 1;
            }
        }
        ans -= 1;
    }

    ans.writeln;
}
