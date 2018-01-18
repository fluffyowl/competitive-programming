import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

const int INF = 1 << 30;

void main() {
    auto N = readln.chomp.to!int;
    auto X = readln.split.map!(to!int).array;
    auto A = readln.split.map!(to!int).array;
    auto B = new int[][](N);
    foreach (i; 0..N-1) B[A[i]-1] ~= i+1;

    auto masks = (1<<N).iota.map!(to!int).array;
    masks.sort();

    auto cur = new int[](1<<N);
    foreach (mask; masks) {
        bool ok = true;
        foreach (i; 0..N) {
            if (!(mask & (1 << i))) continue;
            cur[mask] += X[i];
            foreach (j; B[i]) {
                if (!(mask & (1 << j))) {
                    ok = false;
                }
            }
        }
        if (!ok) {
            cur[mask] = INF;
            continue;
        }

        foreach (i; 0..N) {
            if (!(mask & (1 << i))) continue;
            if (B[i].map!(j => mask & (1<<j)).all) {
                foreach (j; B[i]) {
                    cur[mask] -= X[j];
                }
            }
        }
    }


    auto dp = new int[](1<<N);
    dp.fill(INF);
    dp[0] = 0;

    foreach (mask; masks) {
        foreach (i; 0..N) {
            if (mask & (1<<i)) continue;
            if (cur[mask] == INF || cur[mask|(1<<i)] == INF) continue;
            dp[mask|(1<<i)] = min(dp[mask|(1<<i)], max(dp[mask], cur[mask] + X[i]));
        }
    }

    dp[(1<<N)-1].writeln;
} import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

const int INF = 1 << 30;

void main() {
    auto N = readln.chomp.to!int;
    auto X = readln.split.map!(to!int).array;
    auto A = readln.split.map!(to!int).array;
    auto B = new int[][](N);
    foreach (i; 0..N-1) B[A[i]-1] ~= i+1;

    auto masks = (1<<N).iota.map!(to!int).array;
    masks.sort();

    auto cur = new int[](1<<N);
    foreach (mask; masks) {
        bool ok = true;
        foreach (i; 0..N) {
            if (!(mask & (1 << i))) continue;
            cur[mask] += X[i];
            foreach (j; B[i]) {
                if (!(mask & (1 << j))) {
                    ok = false;
                }
            }
        }
        if (!ok) {
            cur[mask] = INF;
            continue;
        }

        foreach (i; 0..N) {
            if (!(mask & (1 << i))) continue;
            if (B[i].map!(j => mask & (1<<j)).all) {
                foreach (j; B[i]) {
                    cur[mask] -= X[j];
                }
            }
        }
    }


    auto dp = new int[](1<<N);
    dp.fill(INF);
    dp[0] = 0;

    foreach (mask; masks) {
        foreach (i; 0..N) {
            if (mask & (1<<i)) continue;
            if (cur[mask] == INF || cur[mask|(1<<i)] == INF) continue;
            dp[mask|(1<<i)] = min(dp[mask|(1<<i)], max(dp[mask], cur[mask] + X[i]));
        }
    }

    dp[(1<<N)-1].writeln;
}
