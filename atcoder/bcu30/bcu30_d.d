import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;


void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto Q = s[1];
    auto X = readln.split.map!(to!long).array;

    
    auto acm = new long[](N+1);
    acm[0] = 0;
    foreach (i; 0..N) acm[i+1] = acm[i] + X[i];


    foreach (q; 0..Q) {
        auto t = readln.chomp.to!int;
        auto y = X.assumeSorted.lowerBound(t).length;
        long left = y.to!long * t - acm[y];
        long right = (acm[N] - acm[y]) - (N - y.to!long) * t ;
        writeln(left+right);
    }
}
