import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    immutable long MOD = 10^^9 + 7;
    
    auto s = readln.split.map!(to!long);
    auto N = s[0];
    auto K = s[1].to!int;
    auto B = new long[](K+2);
    B[0] = 1;
    auto Comb = new Combination();

    foreach (i; 1..K+2) {
        long S = 0;
        foreach (j; 0..i) {
            S += Comb.comb(i+1, j) * B[j] % MOD;
            S %= MOD;
        }
        B[i] = S * powmod(i+1, MOD-2, MOD) % MOD;
        B[i] = B[i] * (MOD-1) % MOD;
    }

    long ber(int n, long x) {
        long ans = 0;
        foreach (i; 0..n+1) {
            long a = Comb.comb(n, i);
            long b = B[n-i];
            long c = powmod(x % MOD, i, MOD);
            ans += a * b % MOD * c % MOD;
            ans %= MOD;
        }
        return ans;
    }

    long ans = ber(K+1, N+1) - ber(K+1, 0);
    ans = (ans % MOD + MOD) % MOD;
    ans = ans * powmod(K+1, MOD-2, MOD) % MOD;
    ans.writeln;
}

class Combination {
    immutable int MAX = 2*10^^6+1;
    immutable long MOD = 10^^9+7;
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

