import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

immutable long MOD = 10^^9 + 7;
long[] F, G;

void main() {
    F = new long[](202020);
    G = new long[](202020);
    F[0] = F[1] = 1;
    foreach (i; 2..202020) F[i] = i * F[i-1] % MOD;
    foreach (i; 0..202020) G[i] = powmod(F[i], MOD-2, MOD);

    auto N = readln.chomp.to!int;
    auto G = new int[][](N);
    foreach (_; 0..N-1) {
        auto s = readln.split.map!(to!int);
        G[s[0]-1] ~= s[1]-1;
        G[s[1]-1] ~= s[0]-1;
    }
    auto depth = new int[](N);

    void dfs(int n, int p, int d) {
        depth[n] = d;
        foreach (m; G[n]) {
            if (m == p) continue;
            dfs(m, n, d+1);
        }
    }

    dfs(0, -1, 0);
    long ans = 0;

    foreach (i; 0..N) {
        int m = depth[i] + 1;
        (ans += comb(N, m) * F[m-1] % MOD * F[N-depth[i]-1] % MOD) %= MOD;
    }        

    ans.writeln;
}

long comb(long n, long k) {
    if (k > n) return 0;
    return F[n.to!int] * G[n.to!int-k.to!int] % MOD * G[k.to!int] % MOD;
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
