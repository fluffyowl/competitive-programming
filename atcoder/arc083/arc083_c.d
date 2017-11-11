import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

immutable int INF = 1 << 29;

bool solve() {
    auto N = readln.chomp.to!int;
    auto P = readln.split.map!(to!int).array;
    auto X = readln.split.map!(to!int).array;
    auto edges = new int[][](N);
    foreach (i; 0..N-1) {
        edges[i+1] ~= P[i]-1;
        edges[P[i]-1] ~= i+1;
    }

    int dfs(int n, int p) {
        auto dp = new int[][](2, X[n]+1);
        int cur = 0, tar = 1;
        dp[cur].fill(INF);
        dp[cur][0] = 0;

        foreach (m; edges[n]) {
            if (m == p) continue;
            dp[tar].fill(INF);
            int w = dfs(m, n);
            int b = X[m];
            foreach (i; 0..X[n]+1) {
                if (dp[cur][i] != INF) {
                    if (i + w <= X[n]) {
                        dp[tar][i+w] = min(dp[tar][i+w], dp[cur][i]+b);
                    }
                    if (i + b <= X[n]) {
                        dp[tar][i+b] = min(dp[tar][i+b], dp[cur][i]+w);
                    }
                }
            }

            cur ^= 1, tar ^= 1;
        }

        return dp[cur].reduce!min;
    }

    return dfs(0, -1) != INF;
}

void main() {
    writeln( solve ? "POSSIBLE" : "IMPOSSIBLE" );
}
