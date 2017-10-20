import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;
 
 
long powmod(long a, long x, long m) {
    long ret = 1;
    while (x) {
        if (x % 2) ret = ret * a % m;
        a = a * a % m;
        x /= 2;
    }
    return ret;
}
 
void main() {
    auto N = readln.chomp.to!int;
    auto X = new long[](N);
    auto Y = new long[](N);
    foreach (i; 0..N) {
        auto s = readln.split.map!(to!long);
        X[i] = s[0];
        Y[i] = s[1];
    }
 
    bool line(int i, int j, int k) {
        if (X[i] == X[j]) return X[i] == X[k];
        if (Y[i] == Y[j]) return Y[i] == Y[k];
        if (X[i] == X[k]) return X[i] == X[j];
        if (Y[i] == Y[k]) return Y[i] == Y[j];
        return (Y[k] - Y[i]) * (X[j] - X[i]) == (Y[j] - Y[i]) * (X[k] - X[i]);
    }
 
    const long MOD = 998244353;
    auto used = new bool[][](N, N);
    long ans = 1 + N;
 
 
    foreach (i; 0..N) {
        foreach (j; i+1..N) {
            if (used[i][j])
                continue;
            
            long cnt = 2;
            int[] v = [i, j];
 
            foreach (k; j+1..N) {
                if (used[i][k] || !line(i, j, k))
                    continue;
                cnt += 1;
                v ~= k;
            }
 
            foreach (a; 0..v.length)
                foreach (b; a+1..v.length)
                    used[v[a]][v[b]] = true;
 
            ans += powmod(2, cnt, MOD) - cnt - 1;
            ans %= MOD;
        }
    }
 
    ans = powmod(2, N, MOD) - ans;
    ans = (ans % MOD + MOD) % MOD;
    ans.writeln;
}
