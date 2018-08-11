import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long INF = 10L^^10;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto P = s[1].to!long;
    auto A = readln.split.map!(to!long).array;

    long tmp = A[0];
    for (int i = 0, j = 0; i < N; ++i) {
        while (j < N-1 && tmp * A[j+1] <= P) {
            tmp *= A[j+1];
            j += 1;
        }
        if (tmp == P) {
            writeln("Yay!");
            return;
        }
        if (i == N-1) {
            break;
        }
        if (i == j) {
            tmp = A[i+1];
            j = i+1;
        } else {
            tmp /= A[i];
        }
    }

    writeln(":(");
}
