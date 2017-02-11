import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;


void main() {
    immutable long MAX = 2*10^^6+1;
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

    long nck(long n, long k) {
        return f_mod[n] * f_modinv[n-k] % MOD * f_modinv[k] % MOD;
    }


    int H, W, A, B;
    scanf("%d %d %d %d", &H, &W, &A, &B);

    long ans = 0;
    foreach (i; 0..H-A) {
        ans = (ans + nck(B-1+i, i) * nck(W-B+H-i-2, H-i-1) % MOD) % MOD;
    }

    writeln( ans >= 0 ? ans : ans+MOD);
}
