import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

const int INF = 1 << 29;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto uf = new PersistentUnionFind(N);
    foreach (i; 0..M) {
        s = readln.split.map!(to!int);
        uf.unite(s[0]-1, s[1]-1);
    }

    auto Q = readln.chomp.to!int;
    while (Q--) {
        s = readln.split.map!(to!int);
        auto x = s[0]-1;
        auto y = s[1]-1;
        auto z = s[2];
        int hi = M;
        int lo = 0;
        while (hi - lo > 1) {
            int size;
            int mid = (hi + lo) / 2;
            if (uf.find(x, mid) == uf.find(y, mid))
                size = uf.size(x, mid);
            else
                size = uf.size(x, mid) + uf.size(y, mid);
            if (size >= z)
                hi = mid;
            else
                lo = mid;
        }
        hi.writeln;
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
