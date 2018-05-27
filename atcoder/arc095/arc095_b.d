import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!long).array;
    A.sort();
    auto X = A.back;
    A.popBack;

    long y = X / 2;
    long z = X % 2 == 0 ? X / 2 : X / 2 + 1;

    long ans = -1;
    long min_dif = 1L << 59;

    foreach (a; A) {
        long c = abs(a - y);
        long d = abs(a - z);
        long e = min(c, d);
        if (e < min_dif) {
            min_dif = e;
            ans = a;
        }
    }

    writeln(X, " ", ans);
}
