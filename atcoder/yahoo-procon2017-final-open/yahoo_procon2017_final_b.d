import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto K = s[2];
    auto A = readln.split.map!(to!long).array;
    auto B = readln.split.map!(to!long).array;
    A.sort();
    B.sort();

    long hi = 10^^9;
    long lo = -1;

    while (hi - lo > 1) {
        long mid = (hi + lo) / 2;
        int cnt = 0, i = 0, j = 0;
        
        while (i < N && j < M) {
            if (abs(A[i] - B[j]) <= mid) {
                cnt += 1;
                i += 1;
                j += 1;
            } else if (A[i] - B[j] > mid) {
                j += 1;
            } else {
                i += 1;
            }
        }

        if (cnt >= K) {
            hi = mid;
        } else {
            lo = mid;
        }
    }

    hi.writeln;
}
