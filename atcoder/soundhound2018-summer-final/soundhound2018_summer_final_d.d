import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long INF = 1L << 59;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto Q = s[1];


    auto uf = new PersistentUnionFind(N);
    auto added = new bool[int][](N); // add の 記録
    auto completed = new int[](N); // complete の 時間
    completed.fill(-1);
    int t = 0;

    while (Q--) {
        auto q = readln.split.map!(to!int);
        int type = q[0];
        int u = q[1] - 1;
        int v = q[2] - 1;
        if (type == 1) {
            uf.unite(u, v);
            added[u][v] = true;
            added[v][u] = true;
            ++t;
        } else if (type == 2) {
            int p = uf.find(u, t);
            completed[p] = t;
        } else {
            if (v in added[u]) {
                writeln("Yes");
                continue;
            }

            int up = uf.find(u, t);
            int vp = uf.find(v, t);

            if (up != vp || completed[up] == -1) {
                writeln("No");
                continue;
            }


            int up2 = uf.find(u, completed[up]);
            int vp2 = uf.find(v, completed[up]);

            writeln(up2 == vp2 ? "Yes" : "No");
        }
    }

}

class PersistentUnionFind {
    int[][] rank;
    int[][] time;
    int[][] parent;
    int n;
    int global_time;

    this(int n) {
        this.n = n;
        rank = new int[][](n);
        time = new int[][](n);
        parent = new int[][](n);
        foreach (i; 0..n) {
            rank[i] ~= 1;
            time[i] ~= 0;
            parent[i] ~= i;
        }
        global_time = 0;
    }

    void unite(int u, int v) {
        global_time += 1;
        u = find(u, global_time);
        v = find(v, global_time);
        if (u == v) return;

        if (rank[u] < rank[v]) swap(u, v);

        int r = rank[u].back + rank[v].back;

        rank[u] ~= r;
        time[u] ~= global_time;
        parent[u] ~= u;

        rank[v] ~= r;
        time[v] ~= global_time;
        parent[v] ~= u;
    }

    int find(int u, int t) {
        if (parent[u].back == u) return u;
        if (time[u].back > t) return u;
        return find(parent[u].back, t);
    }

    int size(int u, int t) {
        int v = find(u, t);
        int i = time[v].assumeSorted.lowerBound(t+1).length.to!int;
        return rank[v][i-1];
    }
}
