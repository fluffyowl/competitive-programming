import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long MOD = 10^^9 + 7;

void main() {
    auto N = readln.chomp.to!int;
    auto X = new long[](N);
    auto Y = new long[](N);
    auto P = new Tuple!(int, long)[](2*N);
    auto pair = new int[][](N);
    foreach (i; 0..N) {
        auto s = readln.split.map!(to!long);
        X[i] = s[0];
        Y[i] = s[1];
        P[i*2] = tuple(i, X[i]);
        P[i*2+1] = tuple(i, Y[i]);
    }

    P.sort!"a[1] < b[1]"();
    foreach (i; 0..2*N) {
        pair[P[i][0]] ~= i;
    }

    int nodes1 = 2 * N;
    int nodes2 = 1 << (bsr(2 * N) + 2);

    void init_graph(DirectedGraph g, int p) {
        if (p * 2 + 2 >= nodes2) return;
        g.add_edge(p + nodes1, p * 2 + 1 + nodes1);
        g.add_edge(p + nodes1, p * 2 + 2 + nodes1);
        init_graph(g, p * 2 + 1);
        init_graph(g, p * 2 + 2);
    }

    void init_graph_entry(DirectedGraph g) {
        init_graph(g, 0);
    }

    void add_edge(int p, int from, int l, int r, int a, int b, DirectedGraph g) {
        if (r < a || b < l) {
            return;
        }
        if (l <= a && b <= r) {
            g.add_edge(from, p + nodes1);
            return;
        }
        add_edge(2*p+1, from, l, r, a, (a+b)/2, g);
        add_edge(2*p+2, from, l, r, (a+b)/2+1, b, g);
    }

    void add_edge_entry(int from, int l, int r, DirectedGraph g) {
        if (l > r) return;
        add_edge(0, from, l, r, 0, (1 << (bsr(N * 2) + 1)) - 1, g);
    }

    bool solve(long d) {
        auto G = new DirectedGraph(nodes1 + nodes2);
        init_graph_entry(G);
        foreach (i; 0..N) {
            int p1 = pair[i][0];
            int p2 = pair[i][1];
            G.add_edge(p1 + nodes1 + nodes2 / 2 - 1, p2);
            G.add_edge(p2 + nodes1 + nodes2 / 2 - 1, p1);
            G.add_edge(p1, p2 + nodes1 + nodes2 / 2 - 1);
            G.add_edge(p2, p1 + nodes1 + nodes2 / 2 - 1);
        }
        for (int back = 0, i = 0, front = 0; i < N * 2; ++i) {
            while (back < i && P[i][1] - P[back][1] >= d) ++back;
            while (front < N * 2 && P[front][1] - P[i][1] < d) ++front;
            add_edge_entry(i, back, i-1, G);
            add_edge_entry(i, i+1, front-1, G);
        }
        auto scc = new StronglyConnectedComponent(G);

        foreach (i; 0..2*N) {
            if (scc.index[i] == scc.index[i + nodes1 + nodes2 / 2 - 1]) {
                return false;
            }
        }

        return true;
    }


    long hi = 10^^9+1;
    long lo = 0;
    while (hi - lo > 1) {
        long mid = (hi + lo) / 2;
        (solve(mid) ? lo : hi) = mid;
    }
    lo.writeln;
}

class DirectedGraph {
    int n;
    int[][] adj;
    int[][] inv;

    this(int n) {
        this.n = n;
        adj = new int[][](n);
        inv = new int[][](n);
    }

    void add_edge(int u, int v) {
        adj[u] ~= v;
        inv[v] ~= u;
    }
}


class StronglyConnectedComponent : DirectedGraph {
    int[] index;
    int[][] scc;

    this(DirectedGraph g) {
        int cnt = 0;
        auto ord = new int[](g.n);
        auto used = new bool[](g.n);
        index = new int[](g.n);

        void dfs1(int n) {
            if (used[n]) return;
            used[n] = true;
            foreach (m; g.adj[n]) if (!used[m]) dfs1(m);
            ord[cnt++] = n;
        }

        void dfs2(int n) {
            if (used[n]) return;
            used[n] = true;
            index[n] = cnt;
            scc.back ~= n;
            foreach (m; g.inv[n]) if (!used[m]) dfs2(m);
        }

        foreach (i; 0..g.n) if (!used[i]) dfs1(i);

        cnt = 0;
        fill(used, false);

        foreach_reverse (i; 0..g.n) {
            if (used[ord[i]]) continue;
            scc.length += 1;
            dfs2(ord[i]);
            cnt += 1;
        }

        super(cnt);
        auto edge = new bool[int][](cnt);

        foreach (i; 0..g.n)
            foreach (j; g.adj[i])
                if (index[i] != index[j])
                    edge[index[i]][index[j]] = true;

        foreach (i; 0..cnt)
            foreach (j; edge[i].keys)
                add_edge(i, j);
    }
}
