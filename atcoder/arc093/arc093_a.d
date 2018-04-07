import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;


void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!long).array;
    A = 0L ~ A ~ 0L;
    long S = (N+1).iota.map!(i => abs(A[i+1]-A[i])).sum;

    foreach (i; 1..N+1) {
        if ((A[i+1] - A[i]) * (A[i] - A[i-1]) >= 0) {
            S.writeln;
        } else {
            long ans = S;
            ans -= abs(A[i+1] - A[i]) + abs(A[i] - A[i-1]);
            ans += abs(A[i+1] - A[i-1]);
            ans.writeln;
        }
    }
}
