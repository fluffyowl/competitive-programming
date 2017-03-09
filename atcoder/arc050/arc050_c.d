import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio, std.bitmanip;
import std.exception;


long powmod(long a, long x, long m) {
    a %= m;
    long ret = 1;
    while (x) {
        if (x % 2) ret = ret * a % m;
        a = a * a % m;
        x /= 2;
    }
    return ret;
}

long concat(long base, long n, long m, long keta) {
    if (n == 0) return 0;
    auto k = powmod(10, keta, m);
    auto doubling = new long[](63);
    doubling[0] = base % m;
    foreach (i; 1L..63L) {
        doubling[i] = doubling[i-1] * powmod(k, 1L << (i-1), m) % m + doubling[i-1];
        doubling[i] %= m;
    }

    long ret = 0;
    for (long i = 62; i >= 0; i--) {
        if (n & (1L << i)) {
            ret = ret * powmod(k, 1L << i, m) % m;
            ret = (ret + doubling[i]) % m;
        }
    }

    return ret;
}


void main() {
    long a, b, m;
    scanf("%lld %lld %lld", &a, &b, &m);

    long g = gcd(a, b);
    if (g > 1) {
        long p = a / g - 1;
        long base = powmod(10, g-1, m);
        a = concat(base, p, m, g);
        a = (a * 10 % m + 1) % m;
        b = concat(1, b, m, 1);
    }
    else {
        a = concat(1, a, m, 1);
        b = concat(1, b, m, 1);
    }

    writeln(a*b%m);
}
