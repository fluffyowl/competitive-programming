import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

alias Tuple!(int, "to", int, "dist") Edge;
alias Tuple!(int, "x", int, "f") Fare;
immutable int INF = 2 * 10^^9 + 1;

void dijkstra(int s, Edge[][] edges, ref int[] dist) {
    dist[s] = 0;
    auto pq = new BinaryHeap!(Array!Edge, "a.dist > b.dist")();
    pq.insert(Edge(s, 0));

    while (!pq.empty) {
        auto e = pq.front;
        pq.popFront;
        if (e.dist > dist[e.to]) continue;
        dist[e.to] = e.dist;
        foreach (f; edges[e.to]) {
            auto new_dist = e.dist + f.dist;
            if (new_dist >= dist[f.to]) continue;
            dist[f.to] = new_dist;
            pq.insert(Edge(f.to, new_dist));
        }
    }

}

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto K = s[2];
    s = readln.split.map!(to!int);
    auto S = s[0];
    auto G = s[1];
    auto edges = new Edge[][](N);
    foreach (_; 0..M) {
        s = readln.split.map!(to!int);
        edges[s[0]] ~= Edge(s[1], s[2]);
        edges[s[1]] ~= Edge(s[0], s[2]);
    }
    auto XF = new Fare[](K);
    foreach (i; 0..K) {
        s = readln.split.map!(to!int);
        XF[i] = Fare(s[0], s[1]);
    }

    auto D1 = new int[](N);
    auto D2 = new int[](N);
    fill(D1, INF);
    fill(D2, INF);
    dijkstra(S, edges, D1);
    dijkstra(G, edges, D2);


    int cost(int d) {
        int ret = 0;
        foreach (i; 0..K) {
            if (d < XF[i].x) return ret;
            ret = XF[i].f;
        }
        return ret;
    }


    int ans = INF;
    foreach (i; 0..N) {
        ans = min(ans, cost(D1[i]) + cost(D2[i]));
    }

    ans.writeln;
}
