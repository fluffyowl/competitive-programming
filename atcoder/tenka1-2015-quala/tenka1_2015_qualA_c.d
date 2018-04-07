import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long MOD = 10^^9 + 7;


void main() {
    auto s = readln.split.map!(to!int);
    auto H = s[0];
    auto W = s[1];
    auto A = H.iota.map!(_ => readln.split.map!(to!int).array).array;
    auto B = H.iota.map!(_ => readln.split.map!(to!int).array).array;

    auto source = H * W;
    auto sink = H * W + 1;
    auto ff = new FordFulkerson(H * W + 2, source, sink);
    foreach (i; 0..H) foreach (j; 0..W) if ((i + j) % 2) ff.add_edge(source, i * W + j, 1); else ff.add_edge(i * W + j, sink, 1);

    auto dr = [0, 0, 1, -1];
    auto dc = [1, -1, 0, 0];

    foreach (r; 0..H) {
        foreach (c; 0..W) {
            if ((r + c) % 2 == 0) continue;
            foreach (i; 0..4) {
                auto nr = r + dr[i];
                auto nc = c + dc[i];
                if (nr < 0 || nr >= H || nc < 0 || nc >= W) continue;
                if (A[r][c] != B[r][c] && A[nr][nc] != B[nr][nc] && A[r][c] == B[nr][nc]) ff.add_edge(r * W + c, nr * W + nc, 1);
            }
        }
    }

    int match = ff.run.to!int;
    int cnt = 0;
    foreach (i; 0..H) foreach (j; 0..W) cnt += A[i][j] != B[i][j];
    int ans = match + (cnt - match * 2);

    ans.writeln;
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
