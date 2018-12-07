import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long MOD = 998244353;

void main() {
    auto N = readln.chomp.to!int;
    auto P = N.iota.map!(_ => readln.split.map!(to!long).array).array;

    int parity = abs(P[0][0] + P[0][1]) % 2;

    foreach (p; P) {
        if (abs(p[0] + p[1]) % 2 != parity) {
            writeln(-1);
            return;
        }
    }

    int M = 32;
    long[] D = M.iota.map!(i => 1L << i).array;
    if (parity == 0) D = 1 ~ D;
    D.length.writeln;
    D.map!(to!string).join(" ").writeln;
    D.reverse();


    foreach (p; P) {
        long x = p[0];
        long y = p[1];
        dchar[] ans;
        foreach (d; D) {
            if (abs(x) >= abs(y)) {
                if (x >= 0) {
                    x -= d;
                    ans ~= 'R';
                } else {
                    x += d;
                    ans ~= 'L';
                }
            } else {
                if (y >= 0) {
                    y -= d;
                    ans ~= 'U';
                } else {
                    y += d;
                    ans ~= 'D';
                }
            }
        }
        ans.reverse();
        ans.writeln;
    }
}
