import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;


alias Tuple!(int, "to", int, "cost") Edge;
immutable int INF = 1 << 29;

void solve() {
    auto N = readln.chomp.to!int;
    auto A = N.iota.map!(_ => readln.split.map!(to!int).array).array;
    foreach (i; 0..N) if (A[i][i] != 0) {writeln("NO"); return;}
    foreach (i; 0..N) foreach (j; 0..N) if (A[i][j] == -1) A[i][j] = INF;
    auto D = new int[][](N, N);


    foreach (k; 0..N) {
        foreach (i; 0..N) {
            foreach (j; 0..N) {
                auto d = A[i][k] + A[k][j];
                if (d < A[i][j]) {
                    writeln("NO");
                    return;
                }
            }
        }
    }

    writeln("YES");

}

void main() {
    auto T = readln.chomp.to!int;
    while (T--) solve;

}
