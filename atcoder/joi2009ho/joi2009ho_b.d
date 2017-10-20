import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;


void main() {
    auto D = readln.chomp.to!int;
    auto N = readln.chomp.to!int;
    auto M = readln.chomp.to!int;
    auto P = new int[N];
    P[0] = 0;
    foreach (i; 1..N)
        P[i] = readln.chomp.to!int;
    P.sort();

    long ans = 0;

    foreach (_; 0..M) {
        auto K = readln.chomp.to!int;
        auto lb = P.assumeSorted.lowerBound(K + 1).length.to!int - 1;
        ans += min(K - P[lb], (P[(lb+1)%N] + D - K) % D);
    }

    ans.writeln;
}
