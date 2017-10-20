import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

immutable long INF = 1L << 60;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto edges = new Tuple!(int, long)[][](N);
    foreach (_; 0..M) {
        s = readln.split.map!(to!int);
        edges[s[0]] ~= tuple(s[1], s[2].to!long);
        edges[s[1]] ~= tuple(s[0], s[2].to!long);
    }

    auto dist = new long[][](N, 28);
    foreach (i; 0..N) fill(dist[i], INF);

    DList!(Tuple!(int, long)) queue;
    queue.insertBack(tuple(0, 0L));

    while (!queue.empty) {
        auto t = queue.front;
        queue.removeFront;
        int n = t[0];
        long d = t[1];
        int p = d % 28;
        if (dist[n][p] <= d) continue;
        dist[n][p] = d;

        if (n == N - 1) continue;

        foreach (tt; edges[n]) {
            int m = tt[0];
            long cost = tt[1];
            long nd = d + cost;
            int np = nd % 28;
            if (dist[m][np] <= nd) continue;
            queue.insertBack(tuple(m, nd));
        }
    }

    long ans = INF;
    foreach (i; 0..28) if (i % 4 == 0 || i % 7 == 0) ans = min(ans, dist[N-1][i]);
    ans.writeln;
}
