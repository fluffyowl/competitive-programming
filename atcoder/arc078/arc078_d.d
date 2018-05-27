import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    immutable int INF = 1 << 29;
    
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto G = new int[][](N, N);
    foreach (_; 0..M) {
        s = readln.split.map!(to!int);
        G[s[0]-1][s[1]-1] = s[2];
        G[s[1]-1][s[0]-1] = s[2];
    }

    int cost_sum = 0;
    foreach (i; 0..N) foreach (j; i+1..N) cost_sum += G[i][j];
    
    auto cost = new int[](1<<N);
    foreach (mask; 0..(1<<N)) {
        foreach (i; 0..N) {
            foreach (j; i+1..N) {
                if (!(mask & (1 << i))) continue;
                if (!(mask & (1 << j))) continue;
                cost[mask] += G[i][j];
            }
        }
    }

    auto dp = new int[][](1<<N, N);
    foreach (i; 0..(1<<N)) dp[i].fill(-INF);
    foreach (i; 0..N) dp[1][0] = 0;

    auto masks = (1<<N).iota.array;
    masks.sort!((a, b) => a.popcnt < b.popcnt);

    foreach (mask; masks) {
        foreach (i; 0..N) {
            if (!(mask & (1 << i))) continue;
            
            foreach (j; 0..N) {
                if (mask & (1 << j)) continue;
                if (G[i][j] == 0) continue;
                dp[mask|(1<<j)][j] = max(dp[mask|(1<<j)][j], dp[mask][i] + G[i][j]);
            }
            
            int comp = (~mask) & ((1 << N) - 1);
            for (int U = (1 << N) - 1; U >= 0; --U) {
                U &= comp;
                dp[mask|U][i] = max(dp[mask|U][i], dp[mask][i] + cost[U|(1<<i)]);
            }            
        }
    }

    int ans = cost_sum - dp[(1<<N)-1][N-1];
    ans.writeln;
}
