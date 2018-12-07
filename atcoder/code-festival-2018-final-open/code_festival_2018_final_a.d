import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long INF = 1L << 59;
immutable long X = 2540;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto G = new long[long][](N);
    foreach (i; 0..M) {
        s = readln.split.map!(to!int);
        int u = s[0] - 1;
        int v = s[1] - 1;
        long c = s[2];
        G[u][c] += 1;
        G[v][c] += 1;
    }
    long ans = 0;

    foreach (i; 0..N) {
        auto K = G[i].keys.array;
        K.sort();
        foreach (k; K) {
            if (k > X / 2) {
                break;
            } else if (k == X / 2) {
                ans += G[i][k] * (G[i][k] - 1) / 2;
            } else if ((X - k) in G[i]) {
                ans += G[i][k] * G[i][X - k];
            }
        }
    }

    ans.writeln;
}
