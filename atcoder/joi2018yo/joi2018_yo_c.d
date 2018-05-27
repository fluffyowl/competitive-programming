import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto s = readln.split.map!(to!int);
    auto H = s[0];
    auto W = s[1];
    auto A = H.iota.map!(_ => readln.split.map!(to!long).array).array;
    long ans = 1L << 59;

    foreach (i; 0..H) {
        foreach (j; 0..W) {
            long tmp = 0;
            foreach (a; 0..H) {
                foreach (b; 0..W) {
                    tmp += A[a][b] * min(abs(a-i), abs(b-j));
                }
            }
            ans = min(ans, tmp);
        }
    }

    ans.writeln;
}
