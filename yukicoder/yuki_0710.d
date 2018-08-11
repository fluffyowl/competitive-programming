import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable int MAX = 100001;
immutable int INF = 1 << 29;

void main() {
    auto N = readln.chomp.to!int;
    auto V = N.iota.map!(_ => readln.split.map!(to!int).array).array;
    auto dp = new int[][](2, MAX);
    fill(dp[0], INF);
    dp[0][0] = 0;

    int cur = 0, tar = 1;
    foreach (i; 0..N) {
        fill(dp[tar], INF);
        foreach (j; 0..MAX) {
            dp[tar][j] = min(dp[tar][j], dp[cur][j] + V[i][1]);
            if (j + V[i][0] < MAX)
                dp[tar][j+V[i][0]] = min(dp[tar][j+V[i][0]], dp[cur][j]);
        }
        swap(cur, tar);
    }

    MAX.iota.map!(i => max(i, dp[cur][i])).reduce!min.writeln;
}

