import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long zero = false;
immutable long one = true;
immutable long two = one << one;
immutable long three = two + one;
immutable long four = two << one;
immutable long five = four + one;
immutable long six = four + two;
immutable long seven = four + three;
immutable long eight = four << one;
immutable long nine = eight + one;
immutable long ten = eight + two;

immutable string str_A = ((one << six) + one).to!char.to!string;
immutable string str_B = ((one << six) + two).to!char.to!string;
immutable string op_mul = (ten + ten + ten + ten + two).to!char.to!string;
immutable string op_mod = (ten + ten + ten + seven).to!char.to!string;

immutable long MOD = ten ^^ nine + seven;

long mul(long A, long B) {
    A = mod(A, MOD);
    B = mod(B, MOD);
    return mixin(str_A ~ op_mul ~ str_B);
}

long mod(long A, long B) {
    return mixin(str_A ~ op_mod ~ str_B);
}

long[][] matmul(int N, long[][] m_one, long[][] m_two) {
    auto ret = new long[][](N, N);
    foreach (i; zero..N) {
        foreach (j; zero..N) {
            ret[i][j] = zero;
            foreach (k; zero..N) {
                ret[i][j] += mul(m_one[i][k], m_two[k][j]);
                ret[i][j] = mod(ret[i][j], MOD);
            }
        }
    }
    return ret;
}

long[][] matpow(int N, long K, long[][] mat) {
    auto ret = new long[][](N, N);
    foreach (i; zero..N)
        foreach (j; zero..N)
            ret[i][j] = i == j ? one : zero;

    while (K > zero) {
        if ((K & one) == one)
            ret = matmul(N, ret, mat);
        mat = matmul(N, mat, mat);
        K >>= one;
    }

    return ret;
}

long fib(long n) {
    long[][] m = [[one, one], [one, zero]];
    return matpow(two, n, m)[zero][zero];
}

void main() {
    int T = readln.chomp.to!int;
    while (T--) {
        long N = readln.chomp.to!long;
        if (N == one) {
            one.writeln;
        } else if (N == two) {
            three.writeln;
        } else {
            long a = fib(N + one);
            long b = fib(N - three);
            long c = mod(a - b, MOD);
            long d = mod(c + MOD, MOD);
            d.writeln;
        }
    }
}

