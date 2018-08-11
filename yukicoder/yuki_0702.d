import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

uint x = 0, y = 1, z = 2, w = 3;
uint generate() {
    uint t = (x^(x<<11));
    x = y;
    y = z;
    z = w;
    w = (w ^ (w >> 19)) ^ (t ^ (t >> 8));
    return w;
}

void main() {
    int N = 10000001;
    int M = N / 2 + 1;
    int K = 10^^8;
    uint seed = readln.chomp.to!uint;
    x = seed;
    int less = 0;
    uint hoge = 2140000000;
    uint[] A;

    foreach (_; 0..N) {
        uint a = generate();
        if (a >= hoge && a < hoge + K)
            A ~= a;
        else if (a < hoge)
            less += 1;
    }

    A.sort();

    foreach (i; 0..A.length) {
        if (less + 1 >= M) {
            writeln(A[i]);
            return;
        } else {
            less += 1;
        }
    }
}

