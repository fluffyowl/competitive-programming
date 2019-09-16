import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;

const long MOD = 10^^9 + 9;
const long BASE = 31;

void main() {
    auto S = readln.chomp;
    auto N = S.length.to!int;
    auto T = S.to!(dchar[]).reverse.to!string;

    if (is_kaibun(S)) {
        writeln(N-1);
        return;
    }

    auto P = new long[](N+1);
    auto P_INV = new long[](N+1);
    P[0] = P_INV[0] = 1;
    foreach (i; 0..N) P[i+1] = P[i] * BASE % MOD;
    foreach (i; 0..N) P_INV[i] = powmod(P[i], MOD-2, MOD);

    auto rh = new long[](N+1);
    rh[N] = 0;
    foreach (i; 0..N) rh[i+1] = (rh[i] + (S[i] - 'a') * P[i]) % MOD;

    auto hr = new long[](N+1);
    hr[N] = 0;
    foreach (i; 0..N) hr[i+1] = (hr[i] + (T[i] - 'a') * P[i]) % MOD;

    long hash_substr(int l, int r) { // [l, r]
        return ((rh[r+1] - rh[l]) * P_INV[l] % MOD + MOD) % MOD;
    }

    long hash_reverse(int l, int r) {
        int nl = N - r - 1;
        int nr = N - l - 1;
        return ((hr[nr+1] - hr[nl]) * P_INV[nl] % MOD + MOD) % MOD;
    }

    int bin_search(int r1, int l2) {
        if (r1 < 0 || l2 >= N)
            return -1;
        int hi = min(r1+1, N-l2);
        int lo = -1;
        while (hi - lo > 1) {
            int mid = (hi + lo) / 2;
            int l1 = r1 - mid;
            int r2 = l2 + mid;
            if (hash_substr(l1, r1) == hash_reverse(l2, r2))
                lo = mid;
            else
                hi = mid;
        }
        return lo;
    }


    int ans = 0;

    foreach (i; 0..N) { // S[i]が中心
        int len1 = bin_search(i-1, i+1) + 1;
        int r1 = i - len1 - 1;
        int l2 = i + len1 + 1;
        int len2 = max(bin_search(r1-1, l2), bin_search(r1, l2+1)) + 1;
        ans = max(ans, len1 * 2 + len2 * 2 + 1);
    }

    foreach (i; 0..N-1) { // S[i..i+1]が中心
        int len1 = bin_search(i, i+1) + 1;
        int r1 = i - len1;
        int l2 = i + len1 + 1;
        int len2 = max(bin_search(r1-1, l2), bin_search(r1, l2+1)) + 1;
        ans = max(ans, len1 * 2 + len2 * 2);
    }


    ans.writeln;
}

bool is_kaibun(string s) {
    return iota(s.length/2).map!(i => s[i] == s[s.length.to!int-i-1]).all;
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

