import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto K = s[1];
    auto H = N.iota.map!(_ => readln.chomp.to!int).array;

    auto A = new int[](N);
    A[0] = H[0];
    foreach (i; 0..N-1) A[i+1] += A[i] + H[i+1];

    auto a = N.iota.array;
    int ans = 0;

    do {
        auto B = A.dup;
        int x = 1;
        foreach (b; a) {
            if (B[b] > K) {
                x = 0;
                break;
            }
            foreach (i; b..N) B[i] -= H[b];
        }
        ans += x;
    } while (nextPermutation(a));

    ans.writeln;
}
