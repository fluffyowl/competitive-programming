import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto V = s[1];
    auto X = readln.split.map!(to!int).array;

    int[] NS = [V];

    while (NS.back > 0) {
        NS ~= NS.back / 2;
    }

    int K = NS.length.to!int;
    int[][] L = new int[][](K);
    int[][] R = new int[][](K);

    foreach (i, n; NS.enumerate) {
        int l = -1;
        int r = -1;
        foreach (j; 0..N) {
            if (l == -1) {
                l = j;
                r = j;
            } else if (X[j] - X[j-1] <= n) {
                r = j;
            } else {
                L[i] ~= l;
                R[i] ~= r;
                l = j;
                r = j;
            }
        }

        L[i] ~= l;
        R[i] ~= r;
    }


    auto dp1 = new int[](1 << K);
    auto dp2 = new int[](1 << K);
    dp1.fill(-1);
    dp2.fill(N);

    foreach (mask; 0..(1 << K)) {
        foreach (i; 0..K) {
            if (mask & (1 << i)) continue;
            auto next1 = R[i].assumeSorted.upperBound(dp1[mask]);
            auto next2 = L[i].assumeSorted.lowerBound(dp2[mask]);
            dp1[mask|(1<<i)] = max(dp1[mask|(1<<i)], dp1[mask]);
            dp2[mask|(1<<i)] = min(dp2[mask|(1<<i)], dp2[mask]);
            if (!next1.empty) dp1[mask|(1<<i)] = max(dp1[mask|(1<<i)], next1.front);
            if (!next2.empty) dp2[mask|(1<<i)] = min(dp2[mask|(1<<i)], next2.back);
        } 
    }

    auto ok = new bool[](L[0].length);
    
    foreach (mask1; 0..(1<<K)) {
        if (mask1 & 1) continue;
        int mask2 = (1 << K) - 1;
        mask2 ^= mask1;
        mask2 &= ~1;
        foreach (i; 0..L[0].length) {
            if (dp1[mask1] + 1 >= dp2[mask2]) {
                ok[i] = true;
            } else if (L[0][i] <= dp1[mask1] + 1 && dp2[mask2] - 1 <= R[0][i]) {
                ok[i] = true;
            }
            
        }
    }

    
    foreach (i; 0..L[0].length) {
        foreach (j; L[0][i]..R[0][i]+1) {
            writeln(ok[i] ? "Possible" : "Impossible");
        }
    }
}
