import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long MOD = 10^^9 + 7;


void main() {
    auto N = readln.chomp.to!long;
    auto s = readln.split.map!(to!long);
    auto n = s[0];
    auto k = s[1];
    long ans = G(n, k);

    long dfs(long n, long k, long rest) {
        if (rest == 0) return 0;
        if (n == 1) return rest;
        long cnt = 0;
        long ret = 0;
        foreach (i; 0..k*2+1) {
            if (i % 2 == 0) {
                long tmp = 1;
                foreach (_; 0..n-1) {
                    tmp *= k+1;
                    if (tmp - 1 > rest) return dfs(n-1, k, rest);
                }
                tmp -= 1;
                if (cnt + tmp >= rest) return (ret + dfs(n-1, k, rest - cnt)) % MOD;
                cnt += tmp;
                ret = (ret + G(n-1, k)) % MOD;
            } else {
                if (cnt + 1 == rest) return (ret + n) % MOD;
                ret = (ret + n) % MOD;
                cnt += 1;
            }
        }
        return ret;
    }

    n = 10000;
    outer: while (true) {
        if (n < 5) break;
        long tmp = 1;
        foreach (_; 0..n) {
            tmp *= k+1;
            if (tmp > N) {
                n -= 1;
                continue outer;
            }
        }
        if (tmp <= N) {
            n += 10;
            break;
        }
    }

    ans = (ans - dfs(n, k, N)) % MOD;
    ans = (ans + MOD) % MOD;
    ans.writeln;
}

long G(long n, long k) {
    long ans;
    ans = powmod(k+1, n+1, MOD);
    ans = (ans - k - 1) % MOD;
    ans = ans * powmod(k, MOD-2, MOD) % MOD;
    ans = (ans - n) % MOD;
    ans = (ans + MOD) % MOD;
    return ans;
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

