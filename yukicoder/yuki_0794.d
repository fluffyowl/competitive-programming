import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;

immutable long MOD = 10^^9 + 7;
long[] P2, F, G;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto K = s[1];
    auto A = readln.split.map!(to!long).array;
    A.sort();

    P2 = new long[](N+1);
    F = new long[](N+1);
    G = new long[](N+1);
    P2[0] = F[0] = G[0] = 1;

    foreach (i; 1..N+1) P2[i] = P2[i-1] * 2 % MOD;
    foreach (i; 1..N+1) F[i] = F[i-1] * i % MOD;
    foreach (i; 1..N+1) G[i] = powmod(F[i], MOD-2, MOD);

    long ans = 1;

    for (int i = N-1, j = -1, k = 0; i >= N / 2; --i, ++k) {
        while (j < i-1 && A[i] + A[j+1] <= K) ++j;
        if (j < k) {
            writeln(0);
            return;
        }
        if (i - j == 1) {
            int n = N - k * 2;
            ans = ans * F[n] % MOD * powmod(P2[n/2], MOD-2, MOD) % MOD * G[n/2] % MOD;
            break;
        }
        ans = ans * (j - k + 1) % MOD;
    }

    ans = (ans % MOD + MOD) % MOD;
    ans.writeln;
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

