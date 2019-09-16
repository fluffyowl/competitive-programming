import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;

void main() {
    auto N = readln.chomp.to!int;
    auto AB = N.iota.map!(_ => readln.split.map!(to!int).array).array;
    auto dp = new int[][](1<<N, N);
    foreach (i; 0..(1<<N)) fill(dp[i], 1<<29);
    foreach (i; 0..N) dp[1<<i][i] = 0;

    foreach (mask; 0..(1<<N)) {
        foreach (i; 0..N) {
            if (!(mask & (1 << i))) continue;
            foreach (j; 0..N) {
                if (mask & (1 << j)) continue;
                dp[mask|(1<<j)][j] = min(dp[mask|(1<<j)][j], max(dp[mask][i], AB[i][1] - AB[i][0] + AB[j][0]));
            }
        }
    }

    dp[(1<<N)-1].reduce!min.writeln;
}

