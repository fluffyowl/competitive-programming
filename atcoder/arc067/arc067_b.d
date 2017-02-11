import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio, std.bitmanip;


void main() {
    auto s = readln.split.map!(to!long);
    auto N = s[0].to!int;
    auto A = s[1];
    auto B = s[2];
    auto X = readln.split.map!(to!long);

    long ans = 0;
    foreach (i; 1..N) {
        ans += min((X[i]-X[i-1])*A, B);
    }
    ans.writeln;
}
