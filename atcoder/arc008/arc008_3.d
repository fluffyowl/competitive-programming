import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

void main() {
    int N;
    scanf("%d", &N);
    auto X = new int[](N);
    auto Y = new int[](N);
    auto T = new int[](N);
    auto R = new int[](N);
    foreach (i; 0..N) scanf("%d %d %d %d", &X[i], &Y[i], &T[i], &R[i]);

    auto adj = new real[][](N, N);
    foreach (i; 0..N) {
        foreach (j; 0..N) {
            if (i == j) {
                adj[i][j] = 0;
                continue;
            }
            auto d = sqrt(cast(real)((X[i]-X[j])^^2 + (Y[i]-Y[j])^^2));
            adj[i][j] = d / min(T[i], R[j]);
        }
    }

    immutable real INF = 1L << 40;
    auto dist = new real[](N);
    fill(dist, INF);
    dist[0] = 0;
    auto used = new bool[](N);

    while(true) {
        int v = -1;
        foreach (u; 0..N)
            if (!used[u] && (v == -1 || dist[u] < dist[v]))
                v = u;
        if (v == -1)
            break;
        used[v] = true;
        foreach (u; 0..N)
            dist[u] = min(dist[u], dist[v] + adj[v][u]);
    }

    dist.sort();
    foreach (i; 1..N) {
        dist[i] += N - 1 - i;
    }
    writefln("%.10f", dist.reduce!(max));
}
