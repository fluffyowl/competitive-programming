import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;

bool miller_rabin(BigInt n, int k = 20) {
    if (n == 1) return false;
    if (n == 2) return true;
    if (n % 2 == 0) return false;
    BigInt d = n - 1;
    BigInt s = 0;
    while (d % 2) {
        s += 1;
        d /= 2;
    }
    while (k--) {
        BigInt a = uniform(0L, n.to!long).to!BigInt;
        if (powmod(a, d, n) == 1) continue;
        bool composite = true;
        BigInt r = 1;
        while (s--) {
            if (powmod(a, r * d, n) == n - 1) {
                composite = false;
                break;
            }
            r *= 2;
        }
        if (composite) return false;
    }
    return true;
}

void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!int).array;
    A.sort();
    BigInt ans = -1;

    do {
        BigInt n = A.map!(to!string).join("").to!BigInt;
        if (n <= ans) continue;
        if (miller_rabin(n)) ans = max(ans, n);
    } while (nextPermutation(A));

    ans.writeln;
}

BigInt powmod(BigInt a, BigInt x, BigInt m) {
    BigInt ret = 1;
    while (x) {
        if (x % 2) ret = ret * a % m;
        a = a * a % m;
        x /= 2;
    }
    return ret;
}

