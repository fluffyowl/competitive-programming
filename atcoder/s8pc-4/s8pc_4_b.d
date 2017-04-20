import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto K = s[1];
    auto A = readln.split.map!(to!long).array;

    long ans = 1L << 60;
    foreach (i; 0..(1<<N)) {
        long h_max = A[0];
        int visible = 1;
        long tmp = 0;
        foreach (j; 1..N) {
            if (h_max < A[j]) {
                h_max = A[j];
                visible += 1;
            }
            else if (i & (1 << j)) {
                tmp += h_max - A[j] + 1;
                h_max = h_max + 1;
                visible += 1;
            }
        }

        if (visible >= K) ans = min(ans, tmp);
    }

    ans.writeln;
}
