import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio, std.bitmanip;


void main() {
    auto s = readln.split.map!(to!int).array;
    auto all = s[0];
    auto N = s[1];
    auto M = s[2];
    auto L = N.iota.map!(_ => readln.chomp.to!int).array;

    int left = L[0] - 1;
    int right = all - L[$-1];
    
    int[] B;
    foreach (i; 1..N) {
        if (L[i] - L[i-1] > 1) {
            B ~= L[i] - L[i-1] - 1;
        }
    }

    B.sort();
    int[] A = [0];
    foreach (b; B) {
        A ~= A[$-1] + b;
    }

    auto BS = B.assumeSorted;

    foreach (i; 0..M) {
        auto xy = readln.split.map!(to!int).array;
        auto x = xy[0];
        auto y = xy[1];
        auto lb = BS.lowerBound(x+y).length;
        auto ans = N + A[lb] + (x+y) * (B.length - lb) + min(left, x) + min(right, y);
        ans.writeln;
    }
}
