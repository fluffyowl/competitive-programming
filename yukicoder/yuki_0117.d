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


    int T, N, K;
    char CPH;
    scanf("%d\n", &T);

    foreach(i; 0..T) {
        scanf("%c(%d,%d)\n", &CPH, &N, &K);
        if (CPH == 'C') {
            if (N < K) {writeln(0); continue;}
            writeln(f_mod[N] * f_modinv[N-K] % MOD * f_modinv[K] % MOD);
        }
        else if (CPH == 'P') {
            if (N < K) {writeln(0); continue;}
            writeln(f_mod[N] * f_modinv[N-K] % MOD);
        }
        else {
            if (N == 0 && K == 0) {writeln(1); continue;}
            if (N == 0) {writeln(0); continue;}
            writeln(f_mod[N+K-1] * f_modinv[N-1] % MOD * f_modinv[K] % MOD);
        }
    }
}

