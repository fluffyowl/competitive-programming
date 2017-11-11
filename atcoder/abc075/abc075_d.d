import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto K = s[1];
    auto P = N.iota.map!(_ => readln.split.map!(to!long).array).array;
    P.sort!((a, b) => a[0] < b[0]);
    long ans = -1;

    foreach (i; 0..N) {
        long[] Y = [P[i][1]];
        foreach (j; i+1..N) {
            Y ~= P[j][1];
            if (Y.length < K) continue;
            Y.sort();
            foreach (k; 0..Y.length.to!int-K+1) {
                if (ans == -1)
                    ans = (P[j][0] - P[i][0]) * (Y[k+K-1] - Y[k]);
                else
                    ans = min(ans, (P[j][0] - P[i][0]) * (Y[k+K-1] - Y[k]));
            }
        }
    }

    ans.writeln;
}
