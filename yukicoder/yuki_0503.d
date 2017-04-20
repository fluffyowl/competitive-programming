import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;


immutable long MOD = 10^^9 + 7;

long powmod(long a, long x, long m) {
    long ret = 1;
    while (x) {
        if (x % 2) ret = ret * a % MOD;
        a = a * a % MOD;
        x /= 2;
    }
    return ret;
}

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

    long H(long a, long b) {
        if (a == 0 && b == 0) return 1;
        if (a == 0) return 0;
        if (b == 0) return 1;
        return f_mod[a+b-1] * f_modinv[a-1] % MOD * f_modinv[b] % MOD;
    }

    auto s = readln.split.map!(to!long);
    auto N = s[0];
    auto K = s[1];
    auto D = s[2];

    auto P = new long[](N+1);
    P[0] = 1;
    foreach (i; 0..N) P[i+1] = P[i] * D % MOD;

    auto X = N / (K-1);
    auto Y = N % (K-1);
    if (Y == 0) X -= 1, Y = K-1;

    if (D == 1) {
        writeln(Y);
        return;
    }


    long ans = 0;
    foreach (i; 0..X+1) { // D^i
        auto nokori = X - i; // nokori 個を (Y-1) 個 に分配する場合の数
        auto tmp = Y * powmod(D, i, MOD) % MOD * H(Y-1, X-i) % MOD;
        ans += Y * powmod(D, i, MOD) % MOD * H(Y-1, X-i) % MOD;
        ans %= MOD;
        //writeln(i, " ", tmp);
    }

    ans.writeln;
}

