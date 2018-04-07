import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    immutable long MOD = 10^^9+7;

    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto K = s[1];
    auto L = s[2];

    auto dp = new long[][](N+1, 8^^(K-1));
    dp[0][0] = 1;

    if (L == K) {
        long ans = 1;
        foreach (_; 0..N) ans = ans * 7 % MOD;
        ans.writeln;
        return;
    }

    foreach (i; 0..N) {
        foreach (mask; 0..8^^(K-1)) {
            int a, b, c;
            int fa, fb, fc;
            int tmask = mask;
            foreach (j; 0..K-1) {
                int m = tmask % 8;
                a += m % 2; m /= 2;
                b += m % 2; m /= 2;
                c += m % 2;
                if (j == K-2) {
                    fa = a;
                    fb = b;
                    fc = c;
                }
                tmask /= 8;
            }
            if (a > L || b > L || c > L) continue;

            foreach (k; 1..8) {
                int na, nb, nc;
                na = k % 2; k /= 2;
                nb = k % 2; k /= 2;
                nc = k % 2;
                if (a + na > L || b + nb > L || c + nc > L) continue;
                int nmask = (mask % 8^^(K-2)) * 8 + (nc * 4 + nb * 2 + na);
                dp[i+1][nmask] += dp[i][mask];
                dp[i+1][nmask] %= MOD;
            }
        }
    }

    long ans = 0;
    foreach (mask; 0..8^^(K-1)) {
        ans += dp[N][mask];
        ans %= MOD;
    }

    ans.writeln;
}
