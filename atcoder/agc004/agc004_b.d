import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto X = s[1].to!long;
    auto A = readln.split.map!(to!long).array;
    
    auto mins = new long[][](N, N);
    foreach (i; 0..N) fill(mins[i], 1L << 59);

    foreach (i; 0..N) {
        mins[i][0] = A[i];
        foreach (jj; 1..N) {
            int j = (i - jj + N) % N;
            mins[i][jj] = min(mins[i][jj-1], A[j]);
        }
    }

    long ans = 1L << 59;
    foreach (i; 0..N) {
        long tmp = 0;
        foreach (j; 0..N) tmp += mins[j][i];
        ans = min(ans, tmp + i * X);
    }

    ans.writeln;
}
