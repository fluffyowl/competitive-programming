import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip, core.stdc.string;

void main() {
    auto S = readln.chomp;
    int N = S.length.to!int;
    char f = S[0];
    int cnt = 1;

    foreach (i; 1..N) {
        if (S[i] <= f) {
            cnt += 1;
            f = S[i];
        }
    }

    cnt.writeln;
}
