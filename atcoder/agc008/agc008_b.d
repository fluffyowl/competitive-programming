import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;


void main() {
    auto S = readln.split.map!(to!int);
    auto N = S[0];
    auto K = S[1];
    auto A = readln.split.map!(to!long).array;

    long ans = 0;
    long tmp = 0;
    long s = A.map!(a => max(0, a)).sum;

    foreach (i; 0..K-1) {
        tmp += A[i];
        s -= max(0, A[i]);
    }

    foreach (i; 0..N-K+1) {
        tmp += A[i+K-1];
        s -= max(0, A[i+K-1]);
        ans = max(ans, s + max(0, tmp));
        tmp -= A[i];
        s += max(0, A[i]);
    }

    ans.writeln;
}
