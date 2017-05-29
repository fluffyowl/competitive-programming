import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    immutable int MAX = 2*10^^6+1;
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

    long nck(int n, int k) {
        return f_mod[n] * f_modinv[n-k] % MOD * f_modinv[k] % MOD;
    }

    
    auto s1 = readln.chomp;
    auto d1 = readln.chomp.to!int;
    auto s2 = readln.chomp;
    auto d2 = readln.chomp.to!int;
    auto N  = s1.length.to!int;

    int same, diff;
    foreach (i; 0..N) {
        if (s1[i] == s2[i]) same++;
        else diff++;
    }

    
    long ans = 0;
    foreach (i; 0..diff+1) { // i = Aにd+1を振り分ける数
        int j = diff - i;
        int i_nokori = d1 - i;
        int j_nokori = d2 - j;
        if (i > d1 || j > d2 || i_nokori != j_nokori || i_nokori > same || i_nokori < 0) continue;

        ans += nck(diff, i) * nck(same, i_nokori) % MOD;
        ans %= MOD;
    }

    ans.writeln;
}
