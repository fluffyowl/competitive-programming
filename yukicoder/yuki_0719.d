import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;

immutable int INF = 1 << 29;

bool is_prime(int n) {
    if (n <= 1)
        return false;
    for (int i = 2; i * i <= n; ++i)
        if (n % i == 0)
            return false;
    return true;
}

void main() {
    auto N = readln.chomp.to!int;

    auto P = iota(2, N+1).filter!(i => is_prime(i)).array;
    int cnt = 0;
    for (int i = 0; i < P.length && P[i] * P[i] <= N; ++i, ++cnt) {}

    auto F = new int[][](N+1);
    foreach (i; 2..N+1) {
        int j = i;
        foreach (p; P) {
            while (j % p == 0) {
                F[i] ~= p;
                j /= p;
            }
        }
    }

    auto A = new int[](N+1);
    foreach (i; 2..N+1) foreach (j; 0..cnt) if (i % P[j] == 0) A[i] |= (1 << j);

    auto dp = new int[][](P.length+1, 1<<cnt);
    foreach (i; 0..P.length) fill(dp[i], -INF);
    dp[0][0] = 0;

    foreach (i; 0..P.length.to!int) {
        dp[i+1] = dp[i].dup;
        foreach (mask; 0..(1<<cnt)) {
            if (dp[i][mask] < 0) continue;
            for (int j = P[i]; j <= N; j += P[i]) {
                if (A[j] & mask) continue;
                if (F[j].back > P[i]) continue;
                int nmask = mask | A[j];
                dp[i+1][nmask] = max(dp[i+1][nmask], dp[i][mask] + j);
            }
        }
    }

    dp[P.length].reduce!max.writeln;
}

