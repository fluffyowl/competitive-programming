import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;

immutable long INF = 1L << 59;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto G = new Tuple!(int, long)[][](N);
    foreach (_; 0..M) {
        s = readln.split.map!(to!int);
        G[s[0]-1] ~= tuple(s[1]-1, s[2].to!long);
        G[s[1]-1] ~= tuple(s[0]-1, s[2].to!long);
    }

    auto dist = new long[][](N, 2);
    foreach (i; 0..N) dist[i][] = INF;

    auto pq = new BinaryHeap!(Array!(Tuple!(int, int, long)), "a[2] > b[2]");
    pq.insert(tuple(0, 0, 0L));

    while (!pq.empty) {
        auto n = pq.front[0];
        auto x = pq.front[1];
        auto d = pq.front[2];
        pq.removeFront;
        if (dist[n][x] <= d) continue;
        dist[n][x] = d;
        foreach (e; G[n]) {
            auto m = e[0];
            auto nd = d + e[1];
            if (dist[m][x] > nd) pq.insert(tuple(m, x, nd));
            if (x == 0 && dist[m][1] > d) pq.insert(tuple(m, 1, d));
        }
    }

    0.writeln;
    foreach (i; 1..N) {
        writeln(dist[i][0] + dist[i][1]);
    }
}

