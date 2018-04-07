import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto N = readln.chomp.to!long;
    int[] A = iota(1, 101).array;
    int[] B;
    long ans = 0;

    for (int i = 1; ans < N; ++i) {
        int p = 0;
        long tmp = 1;
        while (p < B.length && ans + tmp * 2 <= N) {
            p += 1;
            tmp *= 2;
        }
        B.insertInPlace(p, i);
        ans += tmp;
    }

    writeln(A.length + B.length);
    (A ~ B).map!(to!string).join(" ").writeln;
}
