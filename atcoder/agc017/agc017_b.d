import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

void main() {
    auto s = readln.split.map!(to!long);
    auto N = s[0];
    auto A = s[1];
    auto B = s[2];
    auto C = s[3];
    auto D = s[4];

    long lb = A - (N - 1) * D;
    long ub = A - (N - 1) * C;

    foreach (i; 0..N) {
        if (lb <= B && B <= ub) {
            "YES".writeln;
            return;
        }
        lb += C + D;
        ub += C + D;
        //writeln(i, " " , lb, " ", ub);
    }

    "NO".writeln;
}
