import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio, std.bitmanip;

immutable int MAX = 10^^3+1;
immutable long MOD = 10^^9+7;
auto modinv = new long[](MAX);
auto f_mod = new long[](MAX);
auto f_modinv = new long[](MAX);
long[][] mem;
int N, A, B, C, D;

long powmod(long a, long x, long m) {
    long ret = 1;
    while (x >= 1) {
        if (x % 2 == 1)
            ret = ret * a % m;
        a = a * a % m;
        x /= 2;
    }
    return ret;
}

long nck(int n, int k) {
    if (n < k) return 0;
    return f_mod[n] * f_modinv[n-k] % MOD * f_modinv[k] % MOD;
}

long dp(int g, int n) {
    if (n == 0) return 1;
    if (n < g) return 0;
    if (g > B) return 0;
    if (mem[g][n] >= 0) return mem[g][n];

    mem[g][n] = dp(g+1, n);
    foreach (i; C..D+1) {
        if (g * i > n) break;
        auto cnt =
            nck(n, g*i) * f_mod[g*i] % MOD
            * powmod(f_modinv[g], i, MOD) % MOD;
        cnt = cnt * f_modinv[i] % MOD;
        mem[g][n] = (mem[g][n] + dp(g+1, n-g*i)*cnt%MOD) % MOD;
    }
    return mem[g][n];
}

void main() {
    modinv[0] = modinv[1] = 1;
    foreach(i; 2..MAX) {
        modinv[i] = modinv[MOD % i] * (MOD - MOD / i) % MOD;
    }

    f_mod[0] = f_mod[1] = 1;
    f_modinv[0] = f_modinv[1] = 1;

    foreach(i; 2..MAX) {
        f_mod[i] = (i * f_mod[i-1]) % MOD;
        f_modinv[i] = (modinv[i] * f_modinv[i-1]) % MOD;
    }

    
    scanf("%d %d %d %d %d", &N, &A, &B, &C, &D);
    mem = new long[][](B+1, N+1);
    foreach (i; 0..B+1) fill(mem[i], -1);
    dp(A, N).writeln;
}
