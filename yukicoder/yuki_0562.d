import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

immutable long MOD = 10^^9 + 7;

void main() {
    auto N = readln.chomp.to!int;
    auto S = N.iota.map!(_ => readln.chomp).array;
    S.sort();

    auto LCP = new long[][](N, N);
    foreach (i; 0..N) {
        foreach (j; 0..N) {
            for (int a = 0, b = 0; a < S[i].length && b < S[j].length && S[i][a] == S[j][b]; a++, b++)
            LCP[i][j]++;
        }
    }

    auto dp = new long[](1 << N);
    auto B = (1 << N).iota.array;
    B.sort!((a, b) => a.popcnt < b.popcnt);
    auto F = new long[](N+1);
    F[0] = 1;
    foreach (i; 0..N) F[i + 1] = F[i] * (i + 1) % MOD;

    foreach (mask; B) {
        foreach (i; 0..N) {
            if (!(mask & (1 << i))) {
                long tmp = 0;
                long l = i - 1;
                long r = i + 1;
                while (l >= 0 && (mask & (1 << l))) l--;
                while (r <  N && (mask & (1 << r))) r++;
                if (l >= 0) tmp = max(tmp, LCP[i][l]);
                if (r <  N) tmp = max(tmp, LCP[i][r]);
                tmp = tmp + 1;
                (dp[mask | (1 << i)] += dp[mask] + tmp * F[mask.popcnt] % MOD) %= MOD;
            }
        }
    }

    auto ans = new long[](N+1);
    foreach(i; 0..(1<<N)) {
        (ans[i.popcnt] += dp[i]) %= MOD;
    }

    ans[1..N+1].each!writeln;
}

long powmod(long a, long x, long m) {
    long ret = 1;
    while (x) {
        if (x % 2) ret = ret * a % m;
        a = a * a % m;
        x /= 2;
    }
    return ret;
}

