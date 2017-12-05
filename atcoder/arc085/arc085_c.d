import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

immutable long INF = 1L << 59;

void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!long).array;
    
    auto source = N;
    auto sink = N+1;
    auto ff = new FordFulkerson(N+2, source, sink);

    foreach (i; 0..N) {
        if (A[i] >= 0) {
            ff.add_edge(source, i, 0);
            ff.add_edge(i, sink, A[i]);
        } else {
            ff.add_edge(source, i, -A[i]);
            ff.add_edge(i, sink, 0);
        }

        for (int j = (i+1)*2; j <= N; j += i+1) {
            ff.add_edge(i, j-1, INF);
        }
    }

    writeln(A.map!(a => max(a, 0)).sum - ff.run);
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
} import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

immutable long INF = 1L << 59;

void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!long).array;
    
    auto source = N;
    auto sink = N+1;
    auto ff = new FordFulkerson(N+2, source, sink);

    foreach (i; 0..N) {
        if (A[i] >= 0) {
            ff.add_edge(source, i, 0);
            ff.add_edge(i, sink, A[i]);
        } else {
            ff.add_edge(source, i, -A[i]);
            ff.add_edge(i, sink, 0);
        }

        for (int j = (i+1)*2; j <= N; j += i+1) {
            ff.add_edge(i, j-1, INF);
        }
    }

    writeln(A.map!(a => max(a, 0)).sum - ff.run);
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
