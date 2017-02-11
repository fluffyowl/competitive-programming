import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio, std.bitmanip;


long ncr(long n, long r, long mod) {
    if (n - r < r)
        r = n - r;
    if (r == 0)
        return 1;
    if (r == 1)
        return n;

    long[] numerator = new long[](r);
    long[] denominator = new long[](r);

    foreach (k; 0..r) {
        numerator[k] = n - r + k + 1;
        denominator[k] = k + 1;
    }

    foreach (p; 2..r+1) {
        long pivot = denominator[p-1];
        if (pivot > 1) {
            long offset = (n-r) % p;
            foreach (k; iota(p-1, r, p)) {
                numerator[k-offset] /= pivot;
                denominator[k] /= pivot;
            }
        }
    }

    long result = 1;
    foreach (k; 0..r) {
        if (numerator[k] > 1)
            result = (result * (numerator[k] % mod)) % mod;
    }

    return result;
}

void main() {
    immutable long MOD = 1777777777L;
    immutable long MAX = 800000L;

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

    long nck(int n, int k) {
        return f_mod[n] * f_modinv[n-k] % MOD * f_modinv[k] % MOD;
    }


    auto s = readln.split;
    long N = s[0].to!long;
    int K = s[1].to!int;

    long ans = 0;
    foreach (i; 0..K+1) {
        long c = nck(K, i) * f_mod[K-i] % MOD;
        if (i % 2 == 1) ans = (ans - c) % MOD;
        else  ans = (ans + c) % MOD;
    }
    ans = (ans * ncr(N, K.to!long, MOD)) % MOD;

    writeln((ans+MOD)%MOD);
}
