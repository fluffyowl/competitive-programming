import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio, std.bitmanip;

immutable INF = 10^^7;
int N, M, a, b, c;
Tuple!(int, int)[][] adj;
bool[][] used_in_shortest;

void dijkstra(int s) {
    auto dist = new int[](N);
    fill(dist, INF);
    dist[s] = 0;
    auto prev = new int[][](N);
    alias Tuple!(int, "from", int, "to", int, "cost") Edge;
    auto q = new BinaryHeap!(Array!Edge, "a.cost >= b.cost");
    q.insert(Edge(-1, s, 0));

    while (!q.empty) {
        auto n = q.front;
        q.removeFront;

        if (n.cost == dist[n.to]) {prev[n.to] ~= n.from;}
        if (dist[n.to] < n.cost) continue;
        foreach (e; adj[n.to]) {
            if (dist[n.to] + e[1] < dist[e[0]]) {
                prev[e[0]] = new int[](0);
                prev[e[0]] ~= n.to;
                dist[e[0]] = dist[n.to] + e[1];
                q.insert(Edge(n.to, e[0], dist[e[0]]));
            }
            else if (dist[n.to] + e[1] == dist[e[0]]) {
                prev[e[0]] ~= n.to;
            }
        }
    }

    foreach (n; 0..N) {
        foreach (m; prev[n]) {
            if (m == -1) continue;
            used_in_shortest[n][m] = true;
            used_in_shortest[m][n] = true;
        }
    }

}

void main() {
    scanf("%d %d", &N, &M);
    adj = new Tuple!(int, int)[][](N);
    foreach (i; 0..M) {
        scanf("%d %d %d", &a, &b, &c);
        adj[a-1] ~= tuple(b-1, c);
        adj[b-1] ~= tuple(a-1, c);
    }
    used_in_shortest = new bool[][](N, N);

    foreach (i; 0..N)
        dijkstra(i);

    int ans = 0;
    foreach (n; 0..N) {
        foreach (j; adj[n]) {
            auto m = j[0];
            if (!used_in_shortest[n][m])
                ans += 1;
        }
    }

    (ans/2).writeln;
}
