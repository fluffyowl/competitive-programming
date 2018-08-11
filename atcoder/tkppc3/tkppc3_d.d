import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto s = readln.split.map!(to!int);
    auto H = s[0];
    auto W = s[1];
    auto Q = s[2];
    auto A = readln.split.map!(to!long).array;
    auto B = readln.split.map!(to!long).array;

    auto AA = new long[][](2, H+1);
    auto BB = new long[](W+1);

    foreach (i; 0..H) {
        foreach (j; 0..2) {
            AA[j][i+1] += AA[j][i];
        }
        AA[i%2][i+1] += A[i];
    }

    foreach (i; 0..W) {
        BB[i+1] += BB[i] + (i % 2 == 0 ? B[i] : -B[i]);
    }


    while (Q--) {
        auto t = readln.split.map!(to!int);
        auto r1 = t[0]-1;
        auto c1 = t[1]-1;
        auto r2 = t[2]-1;
        auto c2 = t[3]-1;
        auto even = (AA[0][r2+1] - AA[0][r1]) * (BB[c2+1] - BB[c1]);
        auto odd  = (AA[1][r2+1] - AA[1][r1]) * (BB[c2+1] - BB[c1]) * (-1);
        writeln(even + odd);
    }
}
