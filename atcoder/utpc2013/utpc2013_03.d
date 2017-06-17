import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

alias Tuple!(int, "to", int, "cost") Edge;
immutable int INF = 1 << 28;

void dijkstra(int s, int[][] edges, ref int[][] dist) {
    dist[s][s] = 0;
    auto pq = new BinaryHeap!(Array!Edge, "a.cost > b.cost")();
    pq.insert(Edge(s, 0));

    while (!pq.empty) {
        auto e = pq.front;
        pq.popFront;
        if (e.cost > dist[s][e.to]) continue;
        foreach (f; edges[e.to]) {
            auto new_cost = e.cost + 1;
            if (new_cost >= dist[s][f]) continue;
            dist[s][f] = new_cost;
            pq.insert(Edge(f, new_cost));
        }
    }

}


void main() {
    auto s = readln.split.map!(to!int);
    auto N1 = s[0];
    auto M1 = s[1];
    auto G1 = new int[][](N1);
    foreach (i; 0..M1) {
        s = readln.split.map!(to!int);
        G1[s[0]] ~= s[1];
        G1[s[1]] ~= s[0];
    }

    s = readln.split.map!(to!int);
    auto N2 = s[0];
    auto M2 = s[1];
    auto G2 = new int[][](N2);
    foreach (i; 0..M2) {
        s = readln.split.map!(to!int);
        G2[s[0]] ~= s[1];
        G2[s[1]] ~= s[0];
    }


    auto D1 = new int[][](N1, N1);
    auto D2 = new int[][](N2, N2);

    foreach (i; 0..N1) fill(D1[i], INF), dijkstra(i, G1, D1);
    foreach (i; 0..N2) fill(D2[i], INF), dijkstra(i, G2, D2);

    int mn = INF;
    int mx = 0;

    foreach (i; 0..N1) D1[i].sort();
    foreach (i; 0..N2) D2[i].sort();

    foreach (i; 0..N1)
        foreach (j; 0..N2) {
            int d = D1[i][$-1] + D2[j][$-1] + 1;
            mn = min(mn, d);
            mx = max(mx, d);
        }

    foreach (i; 0..N1) mn = max(mn, D1[i][$-1]), mx = max(mx, D1[i][$-1]);
    foreach (i; 0..N2) mn = max(mn, D2[i][$-1]), mx = max(mx, D2[i][$-1]);

    writeln(mn, " ", mx);
}
