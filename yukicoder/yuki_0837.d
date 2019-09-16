import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;

void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!long).array;
    A.sort();
    auto B = new long[](N+1);
    foreach (i; 0..N) B[i+1] = A[i] + B[i];
    long ans = 1L << 59;

    if (A.map!(a => a == A.front).all) {
        writeln(1);
        return;
    }

    foreach (i; 1..N) {
        int left = i / 2;
        int right = (N - i - 1) / 2 + i;
        long lv1 = A[left] * (left + 1) - (B[left+1] - B[0]);
        long lv2 = (B[i] - B[left]) - A[left] * (i - left);
        long rv1 = A[right] * (right - i + 1) - (B[right+1] - B[i]);
        long rv2 = (B[N] - B[right]) - A[right] * (N - right);
        ans = min(ans, lv1+lv2+rv1+rv2);
    }

    ans.writeln;
}


