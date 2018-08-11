import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto s = readln.split.map!(to!int);
    auto A = s[0];
    auto B = s[1];
    auto N = s[2];
    auto X = readln.chomp;

    foreach (x; X) {
        if (x == 'S') {
            A = max(0, A-1);
        } else if (x == 'C') {
            B = max(0, B-1);
        } else {
            if (A >= B)
                A = max(0, A-1);
            else
                B = max(0, B-1);
        }
    }

    A.writeln;
    B.writeln;
}
