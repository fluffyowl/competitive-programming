import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

alias Tuple!(int, "a", int, "b", long, "c", long, "t") Edge;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto edges = new Edge[](M);
    foreach (i; 0..M) {
        s = readln.split.map!(to!int);
        edges[i] = Edge(s[0], s[1], s[2], s[3]);
    }

    real hi = 10L ^^ 15;
    real lo = 0;

    foreach (_; 0..100) {
        auto mid = (hi + lo) / 2;
        edges.sort!((a, b) => a.c - mid * a.t < b.c - mid * b.t)();
        auto uf = new UnionFind(N);
        long nume = 0;
        long deno = 0;
        foreach (e; edges) {
            if (e.c <= mid * e.t || uf.find(e.a) != uf.find(e.b)) {
                nume += e.c;
                deno += e.t;
                uf.unite(e.a, e.b);
            } 
        }

        if (1.0L*nume/deno <= mid) hi = mid;
        else lo = mid;
    }

    writefln("%.9f", hi);
}


class UnionFind {
    int N;
    int[] table;
    int[][] group;

    this(int n) {
        N = n;
        table = new int[](N);
        fill(table, -1);
        group = new int[][](N);
        foreach (i; 0..N) group[i] ~= i;
    }

    int find(int x) {
        return table[x] < 0 ? x : (table[x] = find(table[x]));
    }

    void unite(int x, int y) {
        x = find(x);
        y = find(y);
        if (x == y) return;
        if (table[x] > table[y]) swap(x, y);
        foreach (g; group[y]) group[x] ~= g;
        group[y] = [];
        table[x] += table[y];
        table[y] = x;
    }
}
