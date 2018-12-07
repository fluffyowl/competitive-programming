import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!long).array;
    long ans = 0;

    for (int i = 0, j = N - 1; i < j; ) {
        if (A[i] + A[i+1] <= A[j-1] + A[j]) {
            ans += A[i];
            ans += A[i] + 1 + A[i+1];
            if (i+2 < N) A[i+2] += A[i] + 1 + A[i+1] + 1;
            i += 2;
        } else {
            ans += A[j];
            ans += A[j] + 1 + A[j-1];
            if (j-2 >= 0) A[j-2] += A[j] + 1 + A[j-1] + 1;
            j -= 2;
        }
    }

    ans.writeln;
}
