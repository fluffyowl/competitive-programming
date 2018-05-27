import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip, std.regex;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto D = s[1].to!long;
    auto A = readln.split.map!(to!long).array;
    auto B = new long[](N+1);
    B[0] = D;
    foreach (i; 0..N) B[i+1] = min(B[i], abs(B[i] - A[i]));
    auto ans = new bool[](N);

    long x = 1;
    foreach_reverse(i; 0..N) {
        ans[i] = B[i] >= x;
        if (x > A[i] / 2) x += A[i];
    }

    auto Q = readln.chomp.to!int;
    readln.split.map!(i => (ans[i.to!int-1] ? "YES" : "NO")).each!writeln;
}
