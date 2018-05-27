import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    immutable long MOD = 10^^9 + 7;
    
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto W = readln.split.map!(to!int).array;
    auto G = new int[][](N);
    foreach (_; 0..M) {
        s = readln.split.map!(to!int);
        G[s[0]-1] ~= s[1]-1;
    }

    auto D = new int[][](N, N);
    foreach (i; 0..N) foreach (j; 0..N) D[i][j] = i == j ? W[i] : -1;
    foreach (i; 0..N) foreach (j; G[i]) D[i][j] = min(W[i], W[j]);
    foreach (i; 0..N) foreach (j; 0..N) foreach (k; 0..N) D[j][k] = max(D[j][k], min(D[j][i], D[i][k]));

    auto ok = new bool[][](N, N);
    foreach (i; 0..N) foreach (j; 0..N) ok[i][j] = D[i][j] >= W[j];

    immutable int MAX = 1001;
    
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
        return f_mod[n] * f_modinv[n-k] % MOD * f_modinv[k] % MOD;
    }

    long ans = 0;
    auto mem = new long[][](1001, 1001);
    foreach (i; 0..1001) mem[i].fill(-1);

    foreach (i; 0..N) {
        foreach (j; 0..N) {
            if (!ok[i][j]) continue;
            if (mem[W[i]][W[j]] == -1) {
                mem[W[i]][W[j]] = 0;
                foreach (k; 1..W[j]+1) {
                    long tmp = 1;
                    if ((W[j] - k) % 2 == 1) tmp = -1;
                    tmp = tmp * powmod(k, W[i], MOD) % MOD;
                    tmp = tmp * comb(W[j], k) % MOD;
                    mem[W[i]][W[j]] = ((mem[W[i]][W[j]] + tmp) % MOD + MOD) % MOD;
                }
            }
            ans = (ans + mem[W[i]][W[j]]) % MOD;
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

