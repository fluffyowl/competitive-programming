import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;


alias Tuple!(int, "to", BigInt, "cost") Node;
Node[][] edges;

immutable BigInt INF = "10000000000000000000000000000000000000000000000000000000000000000000".to!BigInt;


BigInt bellman_ford(int N, int s) {
    auto dist = new BigInt[](N);
    fill(dist, INF);
    dist[s] = 0;
    foreach (i; 0..N) {
        foreach (v; 0..N) {
            foreach (k; 0..edges[v].length) {
                int to = edges[v][k].to;
                BigInt cost = edges[v][k].cost;
                if (dist[v] != INF && dist[to] > dist[v] + cost) {
                    dist[to] = dist[v] + cost;
                    if (i == N - 1) dist[to] = -INF;
                }
            }
        }
    }

    return -dist[N-1];
}


void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    edges = new Node[][](N);
    foreach (i; 0..M) {
        s = readln.split.map!(to!int);
        int a = s[0] - 1;
        int b = s[1] - 1;
        BigInt c = s[2].to!BigInt;
        edges[a] ~= Node(b, -c);
    }

    BigInt ans = bellman_ford(N, 0);
    writeln(ans == INF || ans == -INF ? "inf" : ans.to!string);
}
