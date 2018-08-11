import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long MOD = 10^^9 + 7;

void main() {
    auto N = readln.chomp.to!int;
    auto Comb = new Combination();

    if (N == 2) {
        writeln(1);
        return;
    }

    if (N == 3) {
        writeln(4);
        return;
    }

    long ans = 0;
    auto steps = new long[](N+1);
    
    foreach (k; 2..N+1) {
        steps[k] = Comb.comb(k-1, N-k-1) * Comb.fact(k) % MOD * Comb.fact(N-k-1) % MOD;
    }

    foreach_reverse(k; 2..N+1) {
        if (steps[k] == 0) continue;
        steps[k] = steps[k] - steps[k-1];
        steps[k] = (steps[k] % MOD + MOD) % MOD;
        ans = (ans + steps[k] * k % MOD) % MOD;
    }
    
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
        if (n < 0 || k < 0 || n < k) return 0;
        return f_mod[n] * f_modinv[n-k] % MOD * f_modinv[k] % MOD;
    }

    long fact(int n) {
        if (n < 0) return 0;
        return f_mod[n];
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
