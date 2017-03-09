import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio, std.bitmanip;


immutable long MOD = 10^^9+7;

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
    auto L = N.iota.map!(_ => readln.chomp.to!int).array.sort().array;

    if (N == 1) {
        writeln(powmod(2, L[0], MOD));
        return;
    }


    int g = 0;
    foreach (a; L[1..$].map!(a => a-L[0])) {
        g = gcd(g, a);
    }

    powmod(2, L[0]+(g+1)/2, MOD).writeln;
}

unittest {
    assert(powmod(2, 6, 100000) == 64);
    assert(powmod(2, 7, 100000) == 128);
}
