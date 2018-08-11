import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;


void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto Q = s[1];
    auto X = readln.split.map!(to!long).array;
    auto Y = new long[](N+1);
    foreach (i; 0..N) Y[i+1] = Y[i] + X[i];

    while (Q--) {
        auto t = readln.split.map!(to!long);
        auto c = t[0];
        auto d = t[1];
        auto lb = X.assumeSorted.lowerBound(c-d+1).length.to!int - 1;
        auto ub = N - X.assumeSorted.upperBound(c+d-1).length.to!int;
        auto mid = X.assumeSorted.lowerBound(c+1).length.to!int - 1;
        long ans1, ans2, ans3;
        ans1 = (lb + 1 + N - ub) * d;
        if (mid >= 0) {
            ans2 = (mid - lb) * c - (Y[mid+1] - Y[lb+1]);
        }
        if (mid <= N-1) {
            ans3 = (Y[ub] - Y[mid+1]) - (ub - mid - 1) * c;
        }
        writeln(ans1 + ans2 + ans3);
    }
}
