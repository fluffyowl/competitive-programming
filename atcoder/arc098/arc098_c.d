import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip, std.datetime;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto K = s[1];
    auto Q = s[2];
    auto A = readln.split.map!(to!long).array;
    auto B = A.dup;
    B.sort();
    B = B.uniq().array;
    int M = B.length.to!int;
    long ans = 1L << 59;

    foreach (i; 0..M) {
        long[] ok;
        long[] tmp;
        foreach (j; 0..N) {
            if (A[j] < B[i]) {
                if (tmp.length >= K) {
                    tmp.sort();
                    ok ~= tmp[0..tmp.length.to!int-K+1].dup;
                }
                tmp = [];
            } else {
                tmp ~= A[j];
            }
        }
        if (tmp.length >= K) {
            tmp.sort();
            ok ~= tmp[0..tmp.length.to!int-K+1].dup;
        }
        ok.sort();
        if (ok.length >= Q) {
            ans = min(ans, ok[Q-1] - B[i]);
        }
    }

    ans.writeln;
}
