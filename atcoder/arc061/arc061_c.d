import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio, std.bitmanip;
 
 
void main() {
    immutable int INF = 2^^30;
    alias Tuple!(int, "st", int, "company") Node;
    
    int N, M, p, q, c;
 
    scanf("%d %d", &N, &M);
    Node[][Node] adj;
    auto cs = new int[][](N);
    foreach (i; 0..M) {
        scanf("%d %d %d", &p, &q, &c);
        adj[Node(p-1, c)] ~= Node(q-1, c);
        adj[Node(q-1, c)] ~= Node(p-1, c);
    }

    foreach (n; adj.keys) {
        adj[n] ~= Node(n.st, 0);
        adj[Node(n.st, 0)] ~= n;
    }

    alias Tuple!(int, "to", int, "company", int, "cost") Route;
    auto queue = new BinaryHeap!(Array!Route, "a.cost > b.cost");

    int[Node] dist;
    foreach (n; adj.keys) {
        dist[n] = n.st == 0 ? 1 : INF;
        if (n.st == 0)
            queue.insert(Route(n.st, n.company, 1));
    }
 
    while(!queue.empty) {
        auto cur = queue.front;
        queue.removeFront;

        if (cur.cost > dist[Node(cur.to, cur.company)]) continue;
 
        foreach (next; adj[Node(cur.to, cur.company)]) {
            int fee = (next.company == 0) ? 1 : 0;
            if (cur.cost + fee >= dist[next]) continue;
            dist[next] = cur.cost + fee;
            queue.insert(Route(next.st, next.company, dist[next]));
        }
    }
 
    int ans = INF;
    foreach (n; adj.keys)
        if (n.st == N-1)
            ans = min(ans, dist[n]);
    writeln(ans == INF ? -1 : ans);
}
