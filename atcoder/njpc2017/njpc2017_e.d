import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio, std.bitmanip;


int N, D, root;
alias Tuple!(int, "to", int, "cost", bool, "dir") Edge;
Edge[][] adj;
int[] revs;
int[][] dist;

Tuple!(int, int) farest(int n, int prev) {
    auto ret = tuple(0, n);
    foreach (m; adj[n]) {
        if (m.to == prev) continue;
        auto t = farest(m.to, n);
        t[0] += m.cost;
        if (t[0] > ret[0]) {
            ret = t;
        }
    }
    return ret;
}

int dfs1(int n, int prev) {
    int ret = 0;
    foreach (m; adj[n]) {
        if (m.to == prev) continue;
        ret += dfs1(m.to, n) + m.dir;
    }
    return ret;
}

void dfs2(int n, int prev, int r) {
    revs[n] = r;
    foreach (m; adj[n]) {
        if (m.to == prev) continue;
        auto diff = m.dir ? -1 : 1;
        dfs2(m.to, n, r + diff);
    }
}

void dfs3(int n, int prev, int d, int b) {
    dist[b][n] = d;
    foreach (m; adj[n]) {
        if (m.to == prev) continue;
        dfs3(m.to, n, d + m.cost, b);
    }
}

void main() {
    scanf("%d %d", &N, &D);

    adj = new Edge[][](N);
    foreach (i; 0..N-1) {
        int a, b, c;
        scanf("%d %d %d", &a, &b ,&c);
        adj[a-1] ~= Edge(b-1, c, true);
        adj[b-1] ~= Edge(a-1, c, false);
    }

    auto f1 = farest(0, -1)[1];
    auto f = farest(f1, -1);
    auto f2 = f[1];
    auto d = f[0];

    revs = new int[](N);

    dfs2(0, -1, dfs1(0, -1));

    dist = new int[][](2, N);
    dfs3(f1, -1, 0, 0);
    dfs3(f2, -1, 0, 1);

    immutable int INF = 10^^9;
    int ans = INF;
    foreach (i; 0..N) {
        if (max(dist[0][i], dist[1][i]) <= D)
            ans = min(ans, revs[i]);
    }

    writeln(ans == INF ? -1 : ans);
}
