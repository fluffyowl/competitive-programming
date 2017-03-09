import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio, std.bitmanip;


alias Tuple!(int, "to", int, "type") Edge;
alias Tuple!(int, "i", int, "cost", int, "typeb") Node;
immutable int INF = 1 << 30;


void main() {
    int N, M;
    scanf("%d %d", &N, &M);
    auto adj = new Edge[][](N);
    foreach (i; 0..M) {
        int a, b, c;
        scanf("%d %d %d", &c, &a, &b);
        adj[a] ~= Edge(b, c);
        adj[b] ~= Edge(a, c);
    }


    auto min_typeb = new int[](N);
    fill(min_typeb, INF);
    min_typeb[0] = 0;
    auto q1 = new BinaryHeap!(Array!(Tuple!(int, int)), "a[1] >= b[1]");
    q1.insert(tuple(0, 0));
    while (!q1.empty) {
        auto cur = q1.front;
        q1.popFront;
        if (min_typeb[cur[0]] < cur[1])
            continue;
        min_typeb[cur[0]] = cur[1];
        foreach (tar; adj[cur[0]]) {
            if (min_typeb[tar.to] <= cur[1] + tar.type)
                continue;
            min_typeb[tar.to] = cur[1] + tar.type;
            q1.insert(tuple(tar.to, cur[1]+tar.type));
        }
    }


    int sq = 0;
    while (sq*(sq+1)/2 <= N) sq++;
    auto dist = new int[][](N);
    foreach (i; 0..N) {
        dist[i] = new int[](min(N, min_typeb[i]+sq+1));
        fill(dist[i], INF);
    }
    fill(dist[0], 0);
    auto q = new BinaryHeap!(Array!Node, "a.cost >= b.cost");
    q.insert(Node(0, 0, 0));

    while (!q.empty) {
        auto cur = q.front;
        q.popFront;
        if (dist[cur.i][cur.typeb] < cur.cost)
            continue;
        dist[cur.i][cur.typeb] = cur.cost;
        foreach (tar; adj[cur.i]) {
            int new_cost, new_typeb;
            if (tar.type == 0) {
                new_cost = cur.cost + 1;
                new_typeb = cur.typeb;
            }
            else {
                new_cost = cur.cost + cur.typeb + 1;
                new_typeb = cur.typeb + 1;
            }

            if (new_typeb >= min(N, min_typeb[tar.to]+sq))
                continue;
            if (dist[tar.to][new_typeb] <= new_cost)
                continue;
            dist[tar.to][new_typeb] = new_cost;
            q.insert(Node(tar.to, new_cost, new_typeb));
        }
    }


    dist.each!(d => d.reduce!(min).writeln);
}
