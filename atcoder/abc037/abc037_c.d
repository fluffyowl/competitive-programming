import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;


void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto K = s[1];
    auto A = readln.split.map!(to!long);

    long ans = A[0..K].sum;
    long tmp = ans;

    foreach (i; 0..N-K) {
        tmp -= A[i];
        tmp += A[i+K];
        ans += tmp;
    }

    ans.writeln;
}
