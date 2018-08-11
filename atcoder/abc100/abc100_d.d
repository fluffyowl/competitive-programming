import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto A = N.iota.map!(_ => readln.split.map!(to!long).array).array;
    long ans = 0;

    foreach (x; [-1, 1])
        foreach (y; [-1, 1])
            foreach (z; [-1, 1]) {
                auto B = new long[][](N, 3);
                foreach (i; 0..N)
                    foreach (j; 0..3)
                        B[i][j] = A[i][j];
                foreach (i; 0..N) {
                    B[i][0] *= x;
                    B[i][1] *= y;
                    B[i][2] *= z;
                }
                long[] tmp = new long[](3);
                B.sort!"a[0]+a[1]+a[2] > b[0]+b[1]+b[2]"();
                foreach (i; 0..M) foreach (j; 0..3) tmp[j] += B[i][j];
                ans = max(ans, abs(tmp[0]) + abs(tmp[1]) + abs(tmp[2]));
            }

    ans.writeln;
}
