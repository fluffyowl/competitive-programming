import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;


void main() {
    auto N = readln.chomp.to!int;
    auto A = N.iota.map!(_ => readln.split.map!(to!int).array).array;
    auto B = N.iota.map!(_ => readln.split.map!(to!int).array).array;

    int source = N*2;
    int sink = N*2+1;
    auto FF = new FordFulkerson(N*2+2, source, sink);
    foreach (i; 0..N) FF.add_edge(source, i, 1);
    foreach (i; 0..N) FF.add_edge(N+i, sink, 1);
    foreach (i; 0..N) foreach (j; 0..N) if (A[i][0] < B[j][0] && A[i][1] < B[j][1]) FF.add_edge(i, N+j, 1);
    FF.run.writeln;
}


class FordFulkerson {
    int N, source, sink;
    int[][] adj;
    int[][] flow;
    bool[] used;

    this(int n, int s, int t) {
        N = n;
        source = s;
        sink = t;
        assert (s >= 0 && s < N && t >= 0 && t < N);
        adj = new int[][](N);
        flow = new int[][](N, N);
        used = new bool[](N);
    }

    void add_edge(int from, int to, int cap) {
        adj[from] ~= to;
        adj[to] ~= from;
        flow[from][to] = cap;
    }

    int dfs(int v, int min_cap) {
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

    int run() {
        int ret = 0;
        while (true) {
            foreach (i; 0..N) used[i] = false;
            int f = dfs(source, int.max);
            if (f > 0)
                ret += f;
            else
                return ret;
        }
    }
}
