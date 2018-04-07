import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

immutable long MOD = 10^^9 + 7;

void main() {
    auto N = readln.chomp.to!int;
    auto A = N.iota.map!(_ => readln.chomp.to!int).array;
    auto pattern = [0, 1, 1, 1, 0, 1, 1, 0];
    long ans = 0;
    
    foreach (init; 0..2^^3) {
        if (pattern[init] != A[0]) continue;
        auto dp = new long[][](N, 2^^3);
        dp[0][init] = 1;
        
        foreach (i; 1..N-1) {
            foreach (cur; 0..2^^3) {
                foreach (tar; 0..2^^3) {
                    if ((cur & 0b011) != (tar >> 1)) continue;
                    if (pattern[tar] != A[i]) continue;
                    dp[i][tar] += dp[i-1][cur];
                    dp[i][tar] %= MOD;
                }
            }
        }

        foreach (last; 0..2^^3) {
            if ((last & 0b001) != (init >> 2)) continue;
            if (pattern[((last & 0b011) << 1) | ((init & 0b010) >> 1)] != A[N-1]) continue;
            ans += dp[N-2][last];
            ans %= MOD;
        }
    }

    ans.writeln;
}

