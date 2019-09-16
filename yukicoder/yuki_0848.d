import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;

immutable long MOD = 10^^9 + 7;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto P = s[2] - 1;
    auto Q = s[3] - 1;
    auto T = s[4].to!long;

    auto G = new Tuple!(int, long)[][](N);
    foreach (_; 0..M) {
        s = readln.split.map!(to!int);
        auto u = s[0] - 1;
        auto v = s[1] - 1;
        auto c = s[2].to!long;
        G[u] ~= tuple(v, c);
        G[v] ~= tuple(u, c);
    }

    auto d0 = dijkstra(N, 0, G);
    auto dp = dijkstra(N, P, G);
    auto dq = dijkstra(N, Q, G);

    if (d0[P] + dp[Q] + dq[0] <= T) {
        writeln(T);
        return;
    }

    long ans = -1;

    foreach (a; 0..N) {
        foreach (b; 0..N) {
            long time = d0[a] + max(dp[a] + dp[b], dq[a] + dq[b]) + d0[b];
            if (time > T) continue;
            ans = max(ans, T - max(dp[a] + dp[b], dq[a] + dq[b]));
        }
    }

    writeln(ans);
}

long[] dijkstra(int N, int s, ref Tuple!(int, long)[][] G) {
    auto dist = new long[](N);
    dist[] = 1L << 59;

    auto pq = new BinaryHeap!(Array!(Tuple!(int, long)), "a[1] > b[1]");
    pq.insert(tuple(s, 0L));

    while (!pq.empty) {
        auto n = pq.front[0];
        auto d = pq.front[1];
        pq.removeFront;
        if (dist[n] <= d) continue;
        dist[n] = d;
        foreach (to; G[n]) {
            auto m = to[0];
            auto nd = d + to[1];
            if (dist[m] <= nd) continue;
            pq.insert(tuple(m, nd));
        }
    }
    return dist;
}
