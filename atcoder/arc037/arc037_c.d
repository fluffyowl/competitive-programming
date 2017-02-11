import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio, std.bitmanip;


void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto K = s[1];
    auto A = readln.split.map!(to!long).array.sort().assumeSorted;
    auto B = readln.split.map!(to!long).array.sort().assumeSorted;

    long hi = 10L^^18+1;
    long lo = 0;
    while (hi - lo > 1) {
        long mid = (hi + lo) / 2;
        int k = 0;
        foreach (a; A) {
            long c = mid / a;
            if (mid % a != 0) c += 1;
            k += B.lowerBound(c).length;
        }
        if (k >= K)
            hi = mid;
        else
            lo = mid;
    }
    lo.writeln;
}
