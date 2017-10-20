import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!long).array;

    long[] B = new long[](N);
    long cnt = 0;
    while (A.reduce!max >= N) {
        long T = 0;
        fill(B, 0);
        foreach (i; 0..N) {
            if (A[i] >= N) {
                B[i] = - A[i] / N;
                T += A[i] / N;
                A[i] %= N;
            }
        }

        foreach (i; 0..N) {
            A[i] += T + B[i];
        }

        cnt += T;

    }

    cnt.writeln;
}
