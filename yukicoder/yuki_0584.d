import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;


void main() {
    immutable int MAX = 4000;
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

    long comb(int n, int k) {
        if (n < k) return 0;
        return f_mod[n] * f_modinv[n-k] % MOD * f_modinv[k] % MOD;
    }

    
    auto s = readln.split.map!(to!int);
    auto N = s[0], R = s[1], G = s[2], B = s[3];
    auto M = max(R, G, B);
    auto RGB = R + G + B;
    long ans = 0;

    foreach (two; 0..RGB/2+1) {
        auto one = RGB - two * 2;
        auto emp = N - two * 2 - one;
        if (M > two + one) continue;
        if (emp + 1 < one + two) continue;
        long tmp1 = comb(emp+1, one) * comb(emp+1-one, two) % MOD;
        foreach (i; max(0, R-one)..min(R, two)+1) {
            long tmp2 = tmp1 * comb(two, i) % MOD * comb(one, R-i) % MOD;
            int one_rest = one - (R-i);
            int two_rest = two - i;
            if (G < two_rest) continue;
            tmp2 = tmp2 * comb(one_rest + i, G - two_rest) % MOD;
            tmp2 = tmp2 * powmod(2, two, MOD);
            ans = (ans + tmp2) % MOD;
        }
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

