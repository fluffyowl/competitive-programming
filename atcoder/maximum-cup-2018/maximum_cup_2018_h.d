import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    immutable long INF = 1L << 59;

    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto G = new Tuple!(int, long)[][](N);
    foreach (_; 0..M) {
        s = readln.split.map!(to!int);
        G[s[0]-1] ~= tuple(s[1]-1, s[2].to!long);
        G[s[1]-1] ~= tuple(s[0]-1, s[2].to!long);
    }
    auto K = readln.chomp.to!int;
    auto A = readln.split.map!(x => x.to!int-1).array;
    auto Q = readln.chomp.to!int;
    int[] B;
    if (Q > 0) B = readln.split.map!(x => x.to!int-1).array;

    auto D = new long[][](N, N);
    foreach (i; 0..N) foreach (j; 0..N) D[i][j] = i == j ? 0 : INF;
    foreach (i; 0..N) foreach (j; G[i]) D[i][j[0]] = j[1];
    foreach (i; 0..N) foreach (j; 0..N) foreach (k; 0..N)
        D[j][k] = min(D[j][k], D[j][i] + D[i][k]);


    long hi = INF;
    long lo = -1;

    while (hi - lo > 1) {
        long mid = (hi + lo) / 2;
        int stones = 0;

        int source = K+Q;
        int sink = K+Q+1;
        auto FF = new FordFulkerson(K+Q+2, source, sink);
        foreach (i; 0..K) FF.add_edge(source, i, 1);
        foreach (i; 0..Q) FF.add_edge(K+i, sink, 1);

        foreach (i; 0..K-1) {
            int u = A[i];
            int v = A[i+1];
            if (D[u][v] <= mid) continue;
            stones += 1;
            foreach (j; 0..Q) if (D[B[j]][v] <= mid) FF.add_edge(i, K+j, 1);
        }

        if (FF.run >= stones) hi = mid;
        else lo = mid;
    }

    hi.writeln;
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
