import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

bool is_prime(long n) {
    for (long i = 2; i * i <= n; ++i)
        if (n % i == 0)
            return false;
    return true;
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

long solve() {
    auto s = readln.split.map!(to!long);
    auto N = s[0];
    auto M = s[1];

    if (M == 1)
        return 0;
    if (N == 0)
        return 1;
    if (N >= M)
        return 0;

    if (is_prime(M)) {
        long ret = M - 1;
        for (long cnt = M - 1; cnt > N; --cnt)
            ret = ret * powmod(cnt, M-2, M) % M;
        return ret;
    } else if (M < 10^^6) {
        long ret = 1;
        for (long i = 2; i <= N; ++i)
            ret = ret * i % M;
        return ret;
    } else {
        return 0;
    }
}

void main() {
    auto T = readln.chomp.to!int;
    while (T--)
        solve.writeln;
}

