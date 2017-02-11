import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio, std.bitmanip;


bool ok(ref long[] A, ref long[] B, long n) {
    long s = n * (n+1) / 2;
    if (A.sum % s != 0)
        return false;
    long m = A.sum / s;
    long x = 0;
    foreach (i; 0..n)
        B[i] -= m;

    foreach (i; 0..n) {
        if (B[i] % n != 0)
            return false;
        long d = abs(B[i] / n);
        x += d;
    }
    return x == m;
}

void main() {
    auto N = readln.chomp.to!long;
    auto A = readln.split.map!(to!long).array;
    auto B = new long[](N);
    foreach (i; 0..N) {
        B[i] = A[(i+1)%N] - A[i];
    }

    writeln(ok(A, B, N) ? "YES" : "NO");
}
