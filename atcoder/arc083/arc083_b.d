import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto N = readln.chomp.to!int;
    auto A = N.iota.map!(_ => readln.split.map!(to!long).array).array;

    bool ok = true;
    auto unused = new int[][](N, N);

    foreach (i; 0..N)
        foreach (j; 0..N)
            foreach (k; 0..N)
                if (A[j][k] > A[j][i] + A[i][k])
                    ok = false;
                else if (i != j && i != k && A[j][k] == A[j][i] + A[i][k])
                    unused[j][k] = true;

    if (!ok) {
        writeln(-1);
    } else {
        long ans = 0;
        foreach (i; 0..N)
            foreach (j; i+1..N)
                if (!unused[i][j])
                    ans += A[i][j];
        ans.writeln;
    }
}
