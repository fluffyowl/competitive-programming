import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio, std.bitmanip;


void main() {
    immutable long MAX = 10000;
    immutable long MOD = 10^^9+7;

    auto modinv = new long[](MAX);
    modinv[0] = modinv[1] = 1;
    foreach(i; 2..MAX) {
        modinv[i] = modinv[MOD % i] * (MOD - MOD / i) % MOD;
    }

    auto f_mod = new long[](MAX);
    auto f_modinv = new long[](MAX);
    f_mod[0] = f_mod[1] = 1;
    f_modinv[0] = f_modinv[1] = 1;

    foreach(i; 2..MAX) {
        f_mod[i] = (i * f_mod[i-1]) % MOD;
        f_modinv[i] = (modinv[i] * f_modinv[i-1]) % MOD;
    }

    long nck(int N, int K) {
        if (N < 0 || N < K) return 0;
        return f_mod[N] * f_modinv[N-K] % MOD * f_modinv[K] % MOD;
    }


    int R, C, X, Y, D, L;
    scanf("%d %d", &R, &C);
    scanf("%d %d", &X, &Y);
    scanf("%d %d", &D, &L);

    if (X*Y == D+L) {
        writeln(nck(D+L, D) * (R-X+1) % MOD * (C-Y+1) % MOD);
        return;
    }


    long ans = 0;
    foreach (i; 0..(1<<4)) { //上下左右
        int x = X;
        int y = Y;
        if (i & (1 << 3)) x--;
        if (i & (1 << 2)) x--;
        if (i & (1 << 1)) y--;
        if (i & (1 << 0)) y--;

        if (i.popcnt % 2 == 0) {
            ans = (ans + nck(x*y, D+L) * nck(D+L, D)) % MOD;
        }
        else {
            ans = (ans - nck(x*y, D+L) * nck(D+L, D)) % MOD;
        }
    }

    ans = ans * (R-X+1) % MOD * (C-Y+1) % MOD;
    if (ans < 0) ans += MOD;
    ans.writeln;
}
