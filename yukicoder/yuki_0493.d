import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    immutable long MOD = 10^^9 + 7;
    immutable int MAX = 63;
    
    auto s = readln.split.map!(to!long);
    auto K = s[0];
    auto L = s[1];
    auto R = s[2];

    auto len = new long[](MAX);
    auto sm = new long[](MAX);
    auto pr = new long[](MAX);
    auto sq = new long[][](MAX);
    pr[0] = 1;

    foreach (i; 1..MAX) {
        len[i] = len[i-1] * 2 + (i*i).to!string.length.to!long;
        sq[i] = (i*i).to!string.map!(c => c == '0' ? 10L : (c - '0').to!long).array;
        sm[i] = sm[i-1] * 2 + sq[i].sum;
        pr[i] = 1;
        foreach (a; sq[i]) pr[i] = pr[i] * a % MOD;
        pr[i] = pr[i] * pr[i-1] % MOD * pr[i-1] % MOD;
    }

    if (K < MAX && len[K.to!int] < R) {
        writeln(-1);
        return;
    }

    Tuple!(long, long) dfs(int n, long k) {
        if (n == 0 || k == 0) return tuple(0L, 1L);
        if (len[n-1] >= k) return dfs(n-1, k);
        if (len[n] < k) return tuple(sm[n], pr[n]);
        k -= len[n-1];
        long s = sm[n-1];
        long p = pr[n-1];
        foreach (d; sq[n]) {
            s = s + d;
            p = p * d % MOD;
            k -= 1;
            if (k == 0) break;
        }
        auto tmp = dfs(n-1, k);
        s = s + tmp[0];
        p = p * tmp[1] % MOD;
        return tuple(s, p);
    }

    auto ans_r = dfs(MAX-1, R);
    auto ans_l = dfs(MAX-1, L-1);
    auto ans_s = ans_r[0] - ans_l[0];
    auto ans_p = ans_r[1] * powmod(ans_l[1], MOD-2, MOD) % MOD;

    writeln(ans_s, " ", ans_p);
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

