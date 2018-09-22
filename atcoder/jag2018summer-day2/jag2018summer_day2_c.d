import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long MOD = 10^^9 + 7;
immutable long INF = 1L << 59;

void main() {
    auto N = readln.chomp.to!long;
    long ans = N % 2;

    long[] F;
    for (long x = 2; x * x <= N; ++x) {
        if (N % x == 0) {
            F ~= x;
            if (x * x < N) F ~= N / x;
        }
    }
    F.sort();

    foreach (f; F) {
        if (f % 2) {
            ans += 1;
        }
        //writeln(N / f / 2);
        ans += N / f / 2;
    }

    ans.writeln;
}
