import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long MOD = 998244353;


void main() {
    auto s = readln.split.map!(to!long);
    auto N = s[0].to!int;
    auto A = s[1];
    auto B = s[2];
    auto K = s[3];
    
    auto Comb = new Combination();
    long ans = 0;
    
    foreach (a; 0..N+1) {
        long b = (K- a * A) / B;
        if ((K - a * A) % B != 0) continue;
        if (b < 0 || b > N) continue;
        ans += Comb.comb(N, a.to!int) * Comb.comb(N, b.to!int) % MOD;
        ans %= MOD;
    }

    ans.writeln;
}


class Combination {
    immutable int MAX = 2*10^^6+1;
    long[] modinv;
    long[] f_mod;
    long[] f_modinv;
    
    this() {
        modinv = new long[](MAX);
        modinv[0] = modinv[1] = 1;
        foreach(i; 2..MAX) {
            modinv[i] = modinv[MOD.to!int % i] * (MOD - MOD / i) % MOD;
        }

        f_mod = new long[](MAX);
        f_modinv = new long[](MAX);
        f_mod[0] = f_mod[1] = 1;
        f_modinv[0] = f_modinv[1] = 1;

        foreach(i; 2..MAX.to!int) {
            f_mod[i] = (i * f_mod[i-1]) % MOD;
            f_modinv[i] = (modinv[i] * f_modinv[i-1]) % MOD;
        }
    }

    long comb(int n, int k) {
        if (n < k) return 0;
        return f_mod[n] * f_modinv[n-k] % MOD * f_modinv[k] % MOD;
    }
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
