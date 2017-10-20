import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

immutable int INF = 1 << 29;

void main() {
    auto s = readln.split.map!(to!int);
    auto H = s[0];
    auto W = s[1];
    auto B = H.iota.map!(_ => readln.chomp).array;

    auto source = H + W;
    auto sink = H + W + 1;
    auto FF = new FordFulkerson(H + W + 2, source, sink);
    int r1, c1, r2, c2;

    foreach (i; 0..H) {
        foreach (j; 0..W) {
            if (B[i][j] == 'S') {
                FF.add_edge(source, i, INF);
                FF.add_edge(source, H + j, INF);
                r1 = i;
                c1 = j;
            } else if (B[i][j] == 'T') {
                FF.add_edge(i, sink, INF);
                FF.add_edge(H + j, sink, INF);
                r2 = i;
                c2 = j;
            } else if (B[i][j] == 'o') {
                FF.add_edge(i, H + j, 1);
                FF.add_edge(H + j, i, 1);
            }
        }
    }

    writeln( (r1 == r2 || c1 == c2) ? -1 : FF.run );
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
