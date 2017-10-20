import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

long MAX = 10 ^^ 9 + 10;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto L = s[1];
    auto H = s[2];
    auto C = readln.split.map!(to!int).array;

    auto cnt = new long[](N+1);

    foreach (mask; 0..(1 << N)) {
        long tmp = 0;
        long lcm = 1;
        foreach (i; 0..N) {
            if (mask & (1 << i)) lcm = lcm == 1 ? C[i] : lcm * C[i] / gcd(lcm, C[i]);
            lcm = min(lcm, MAX);
        }
        //if (mask.popcnt <= 1) continue;
        cnt[mask.popcnt] += H / lcm - (L - 1) / lcm;
    }

    long tmp1 = 0;
    foreach (i; 1..N+1) tmp1 += (i % 2) ? cnt[i]*i : -cnt[i]*i;

    tmp1.writeln;
}

