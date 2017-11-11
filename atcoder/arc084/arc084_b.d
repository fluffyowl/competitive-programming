import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

const int INF = 1 << 29;

void main() {
    auto N = readln.chomp.to!int;

    if (N == 1) {
        writeln(1);
        return;
    }

    auto dist = new int[](N);
    dist.fill(INF);

    auto pq = new BinaryHeap!(Array!(Tuple!(int, int)), "a[1] > b[1]");
    pq.insert(tuple(1, 1));

    while (!pq.empty) {
        auto n = pq.front[0];
        auto c = pq.front[1];
        pq.removeFront;
        if (dist[n] <= c) continue;
        dist[n] = c;
        if (dist[(n+1)%N] > c+1) pq.insert(tuple((n+1)%N, c+1));
        if (dist[(n*10)%N] > c) pq.insert(tuple((n*10)%N, c));
    }

    dist[0].writeln;
}
