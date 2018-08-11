import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto N = readln.chomp.to!int;
    auto L = new long[](N);
    auto R = new long[](N);
    foreach (i; 0..N) {
        auto s = readln.split.map!(to!long);
        L[i] = s[0];
        R[i] = s[1];
    }

    L.sort();
    R.sort();
    long ans = -1;
    long tmp = 0;

    foreach (i; 0..N) {
        tmp += L[$-i-1] * 2;
        ans = max(ans, tmp);
        tmp -= R[i] * 2;
        ans = max(ans, tmp);
    }

    tmp = 0;

    foreach (i; 0..N) {
        tmp -= R[i] * 2;
        ans = max(ans, tmp);
        tmp += L[$-i-1] * 2;
        ans = max(ans, tmp);
    }

    ans.writeln;
}
