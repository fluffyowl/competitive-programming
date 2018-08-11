import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!long).array;
    
    long hi = 10^^9;
    long lo = -(10^^9);

    long calc(long b) {
        return N.iota.map!(i => abs(A[i] - (b+i+1))).sum;
    }
    
    while (hi - lo > 2) {
        long mid1 = (2*hi + lo) / 3;
        long mid2 = (hi + 2*lo) / 3;
        long v1 = calc(mid1);
        long v2 = calc(mid2);
        if (v1 >= v2) hi = mid1;
        else lo = mid2;
    }

    iota(lo, lo+4).map!(b => calc(b)).reduce!min.writeln;
}
