import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long MOD = 10^^9 + 7;
long[] F;

void main() {
    auto S = readln.chomp;
    auto A = readln.chomp.to!int;
    long ans = 0;

    long restW = A;
    long restF = S.length.to!int - A;

    foreach (c; S) {
        if (c == 'W') --restW;
        else if (c == 'F') --restF;
    }

    F = new long[](3*10^^6+1);
    F[0] = 1;
    foreach (i; 1..3*10^^6+1) F[i] = F[i-1] * i % MOD;

    foreach (i; 0..S.length.to!int) {
        int j = (i + 1) % (S.length.to!int);
        if (S[i] != '?' && S[j] != '?' && S[i] != S[j]) {
            ans += comb(restW + restF, restW);
        } else if ((S[i] == '?' && S[j] == 'F') || (S[i] == 'F' && S[j] == '?')) {
            ans += comb(restW - 1 + restF, restW - 1);
        } else if ((S[i] == '?' && S[j] == 'W') || (S[i] == 'W' && S[j] == '?')) {
            ans += comb(restW + restF - 1, restW);
        } else if (S[i] == '?' && S[j] == '?') {
            ans += comb(restW - 1 + restF - 1, restW - 1) * 2 % MOD;
        }
        ans %= MOD;
    }

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

long comb(long n, long r) {
    if (n < 0 || r < 0 || n < r) return 0;
    return F[n] * powmod(F[n-r], MOD-2, MOD) % MOD * powmod(F[r], MOD-2, MOD) % MOD;
}
