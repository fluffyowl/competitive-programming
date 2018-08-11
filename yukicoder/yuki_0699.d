import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!long).array;
    auto B = (1<<N).iota.filter!(b => b.popcnt == N/2).array;
    long ans = 0;

    foreach (mask; B) {
        int[] X;
        int[] Y;
        foreach (i; 0..N)
            (mask & (1 << i) ? X : Y) ~= i;
        do {
            long tmp = 0;
            foreach (i; 0..N/2)
                tmp ^= (A[X[i]] + A[Y[i]]);
            ans = max(ans, tmp);
        } while (nextPermutation(X));
    }

    ans.writeln;
}

