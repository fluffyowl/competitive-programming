import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

immutable long MAX = 2*10^^6+1;
immutable long MOD = 10^^9+7;

long powmod(long a, long x, long m) {
    a %= m;
    long ret = 1;
    while (x) {
        if (x % 2) ret = ret * a % m;
        a = a * a % m;
        x /= 2;
    }
    return ret;
}

void main() {
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


    auto s = readln.split.map!(to!long);
    auto N = s[0];
    auto M = s[1];

    long ans = 0;
    foreach (i; 0..M) {
        long p = nck(M, i) * powmod(M-i, N, MOD) % MOD;
        if (i % 2 == 0)
            ans = (ans + p) % MOD;
        else {
            ans = (ans - p) % MOD;
            ans = (ans + MOD) % MOD;
        }
    }

    writeln((ans + MOD) % MOD);
}

