import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip, std.regex;

void main() {
    immutable long MOD = 10^^9 + 7;

    auto N = readln.chomp.to!int;
    auto A = N.iota.map!(_ => readln.chomp.to!long).array;
    auto X = A.reduce!"a^b"();

    auto B = new bool[](40);
    foreach (a; A) B[bsf(a)] = true;

    int ans = 0;
    foreach_reverse (i; 0..33) {
        if ((X >> i) & 1) {
            if (!B[i]) {
                writeln(-1);
                return;
            }
            ans += 1;
            X ^= (1L << (i + 1)) - 1;
        }
    }

    writeln(X == 0 ? ans : -1);
}
