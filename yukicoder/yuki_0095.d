import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

immutable int INF = 1 << 29;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto K = s[2];
    auto G = new int[][](N);
    auto D = new int[][](N, N);

    foreach (_; 0..M) {
        s = readln.split.map!(to!int);
        G[s[0]-1] ~= s[1]-1;
        G[s[1]-1] ~= s[0]-1;
    }

    foreach (i; 0..N)
        foreach (j; 0..N)
            D[i][j] = i == j ? 0 : INF;

    foreach (i; 0..N)
        foreach (j; G[i])
            D[i][j] = 1;

    foreach (i; 0..N)
        foreach (j; 0..N)
            foreach (k; 0..N)
                D[j][k] = min(D[j][k], D[j][i] + D[i][k]);

    
    bool can_travel(const int[] nodes) {
        int n = nodes.length.to!int;
        auto dp = new int[][](1<<n, n);
        foreach (i; 0..(1<<n)) fill(dp[i], INF);
        dp[1][0] = 0;

        foreach (mask; 1..(1<<n)) 
            foreach (i; 0..n) 
                if ((1 << i) & mask) 
                    foreach (j; 0..n) 
                        if (!((1 << j) & mask)) 
                            dp[mask|(1<<j)][j] = min(dp[mask|(1<<j)][j],
                                                     dp[mask][i] + D[nodes[i]][nodes[j]]);

        return dp[(1<<n)-1].reduce!min <= K;
    }

    int[] S = [0];
    
    foreach_reverse (i; 1..N) {
        S ~= i;
        if (!can_travel(S))
            S.popBack;
        if (S.length == K+1)
            break;
    }

    ulong ans = 0;
    foreach (n; S)
        ans += (1UL << n) - 1;
    ans.writeln;
}

