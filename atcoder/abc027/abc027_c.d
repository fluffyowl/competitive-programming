import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;


void main() {
    auto N = readln.chomp.to!long;
    N = N / 2 + 1;
    int turn = 0;

    while (N > 1) {
        turn ^= 1;
        if (turn) N = N / 2;
        else N = N / 2 + N % 2;
    }

    writeln(turn ? "Takahashi": "Aoki");
}
