import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    immutable int INF = 1 << 29;
    
    auto N = readln.chomp.to!int;
    auto A = N.iota.map!(_ => readln.chomp.to!int).array;
    
    auto B = new int[](N+1);
    foreach (i; 0..N) B[i+1] = A[i] + B[i];
    
    int[int] D;
    D[0] = 0;
    int p = 1;
    foreach (i; 0..N) foreach (j; 1..N+1) if ((B[j]-B[i]) !in D) D[B[j]-B[i]] = p++;

    auto dp = new int[][](N, p);
    foreach (i; 0..N) dp[i].fill(INF);
    
    foreach (i; 0..N) {
        if (i != N-1) dp[i][D[B[i+1]]] = min(dp[i][D[B[i+1]]], B[i+1]);
        foreach (j; D.keys) {
            if (dp[i][D[j]] == INF) continue;
            foreach (k; i+1..N) {
                int d = B[k+1] - B[i+1];
                int mn = min(d, j);
                int mx = max(d, dp[i][D[j]]);
                dp[k][D[mn]] = min(dp[k][D[mn]], mx);
            }
        }
    }

    int ans = INF;
    foreach (k; D.keys) ans = min(ans, dp[N-1][D[k]] - k);
    ans.writeln;
}
