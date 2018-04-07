import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

alias Plane = Tuple!(int, "u", int, "v", int, "p", int, "q", int, "w");
immutable long INF = 1L << 59;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto D = s[2];
    auto P = new Plane[](M);
    foreach (i; 0..M) {
        s = readln.split.map!(to!int);
        P[i] = Plane(s[0], s[1], s[2], s[3], s[4]);
    }

    int source = M;
    int sink = M + 1;
    auto ff = new FordFulkerson(M + 2, source, sink);

    foreach (i; 0..M) {
        if (P[i].u == 1) {
            ff.add_edge(source, i, P[i].w);
        }
        if (P[i].v == N) {
            ff.add_edge(i, sink, P[i].w);
        }
    }

    foreach (i; 0..M) {
        foreach (j; 0..M) {
            if (i == j) continue;
            if (P[i].v == P[j].u && P[j].p - P[i].q >= D) {
                ff.add_edge(i, j, min(P[i].w, P[j].w));
            }
        }
    }

    ff.run.writeln;
}


class FordFulkerson {
    int N, source, sink;
    int[][] adj;
    long[][] flow;
    bool[] used;

    this(int n, int s, int t) {
        N = n;
        source = s;
        sink = t;
        assert (s >= 0 && s < N && t >= 0 && t < N);
        adj = new int[][](N);
        flow = new long[][](N, N);
        used = new bool[](N);
    }

    void add_edge(int from, int to, long cap) {
        adj[from] ~= to;
        adj[to] ~= from;
        flow[from][to] = cap;
    }

    long dfs(int v, long min_cap) {
        if (v == sink)
            return min_cap;
        if (used[v])
            return 0;
        used[v] = true;
        foreach (to; adj[v]) {
            if (!used[to] && flow[v][to] > 0) {
                auto bottleneck = dfs(to, min(min_cap, flow[v][to]));
                if (bottleneck == 0) continue;
                flow[v][to] -= bottleneck;
                flow[to][v] += bottleneck;
                return bottleneck;
            }
        }
        return 0;
    }

    long run() {
        long ret = 0;
        while (true) {
            foreach (i; 0..N) used[i] = false;
            long f = dfs(source, long.max);
            if (f > 0)
                ret += f;
            else
                return ret;
        }
    }
}

