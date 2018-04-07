import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long MOD = 100003;

uint xor128_x = 123456789, xor128_y = 362436069, xor128_z = 521288629, xor128_w = 88675123;
uint xor128() {
    uint t = xor128_x ^ (xor128_x << 11);
    xor128_x = xor128_y; xor128_y = xor128_z; xor128_z = xor128_w;
    return xor128_w = xor128_w ^ (xor128_w >> 19) ^ (t ^ (t >> 8));
}

void generateA(int N, long A[]) {
    for(int i = 0; i < N; ++ i)
        A[i] = xor128() % 100003;
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


void solve1(int N, int Q, long[] A) {
    while (Q--) {
        auto q = readln.chomp.to!long;
        auto B = A.map!(a => a * q % MOD).array;
        B.reduce!max.writeln;
    }
}

void solve2(int N, int Q, long[] A) {
    auto B = new bool[](MOD+1);
    foreach (a; A) B[a.to!int] = true;
    
    while (Q--) {
        auto q = readln.chomp.to!long;
        if (q == 0) {
            writeln(0);
            continue;
        }
        for (long x = MOD-1; x >= 0; --x) {
            auto y = x * powmod(q, MOD-2, MOD) % MOD;
            if (B[y.to!int]) {
                x.writeln;
                break;
            }
        }
    }
}

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto Q = s[1];
    auto A = new long[](N);
    generateA(N, A);

    if (N <= 800) solve1(N, Q, A);
    else solve2(N, Q, A);
}

