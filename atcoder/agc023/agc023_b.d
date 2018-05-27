import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto N = readln.chomp.to!int;
    auto S = N.iota.map!(_ => readln.chomp).array;
    long ans = 0;

    foreach (i; 0..N) {
        bool ok = true;
        int a = 0;
        int b = i;
        foreach (j; 0..N) {
            int c = (a + j) % N;
            int d = (b + j) % N;
            foreach (k; 1..N-j) {
                if (S[(c+k)%N][d] != S[c][(d+k)%N]) {
                    ok = false;
                }
            }
        }
        ans += ok * N;
    }

    ans.writeln;
}
