import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

immutable long INF = 1L << 60;
alias Edge = Tuple!(int, "bld", int, "floor");

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto K = s[2];
    auto S = s[3];
    auto T = s[4];
    auto G = new Edge[][int][](N);
    auto floors = new int[][](N);
    foreach (_; 0..M) {
        s = readln.split.map!(to!int);
        G[s[0]-1][s[1]] ~= Edge(s[0], s[2]);
        floors[s[0]-1] ~= s[1];
        floors[s[0]] ~= s[2];
    }
    floors[0] ~= S;
    floors[N-1] ~= T;

    foreach (i; 0..N) {
        floors[i].sort();
        foreach (j; 0..floors[i].length.to!int-1) {
            G[i][floors[i][j]] ~= Edge(i, floors[i][j+1]);
            G[i][floors[i][j+1]] ~= Edge(i, floors[i][j]);
        }
    }


    auto dist = new long[int][](N);
    foreach (i; 0..N)
        foreach (j; floors[i])
            dist[i][j] = INF;
    
    auto pq = new BinaryHeap!(Array!(Tuple!(int, int, long)), "a[2] > b[2]");
    pq.insert(tuple(0, S, 0L));

    while (!pq.empty) {
        auto tt = pq.front;
        pq.removeFront;
        auto b = tt[0];
        auto f = tt[1];
        auto cost = tt[2];
        if (dist[b][f] <= cost) continue;
        dist[b][f] = cost;
        if (!(f in G[b])) continue;
        
        foreach (e; G[b][f]) {
            auto nb = e.bld;
            auto nf = e.floor;
            auto nc = cost + (b == nb ? abs(f-nf) : 0L);
            if (nc < dist[nb][nf]) pq.insert(tuple(nb, nf, nc));
        }
    }

    if (dist[N-1][T] >= INF) dist[N-1][T] = -1;
    dist[N-1][T].writeln; 
}

