import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;


alias Tuple!(int, "to", int, "color", long, "cost") Edge;
alias Tuple!(int, "at", int, "color", long, "cost") Node;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto edges = new Edge[][](N);
    foreach (i; 0..M) {
        s = readln.split.map!(to!int);
        edges[s[0]-1] ~= Edge(s[1]-1, s[2], s[3]);
        edges[s[1]-1] ~= Edge(s[0]-1, s[2], s[3]);
    }


    auto dist = new long[int][](N);
    dist[0][1] = 0;
    auto pq = BinaryHeap!(Array!Node, "a.cost >= b.cost")();
    pq.insert(Node(0, 1, 0));
    while (!pq.empty) {
        auto node = pq.front;
        auto from = node.at;
        auto color = node.color;
        auto cost = node.cost;
        pq.removeFront;
        if (color in dist[from] && dist[from][color] < cost) continue;
        dist[from][color] = cost;

        foreach (e; edges[from]) {
            long ncost = cost + abs(color-e.color) + e.cost;
            if (e.color in dist[e.to] && dist[e.to][e.color] <= ncost) continue;
            dist[e.to][e.color] = ncost;
            pq.insert(Node(e.to, e.color, ncost));
        }
    }

    long ans = 1L << 60;
    foreach (k; dist[N-1].keys) {
        ans = min(ans, dist[N-1][k]);
    }
    ans.writeln;
}
