import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;


immutable long MOD = 10^^9 + 7;
immutable long INF = 1L << 60;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto Q = s[1];

    auto uf = new UnionFind(N);

    while (Q--) {
        auto q = readln.split.map!(to!int);
        auto w = q[0];
        auto x = q[1] - 1;
        auto y = q[2] - 1;
        auto z = q[3];

        if (w == 1) {
            int ox = uf.find(x);
            int oy = uf.find(y);
            if (z % 2 == 0) {
                if (uf.edges[ox] != -1 && uf.edges[oy] != -1)
                    uf.unite(uf.edges[ox], uf.edges[oy]);
                uf.unite(x, y);
            }
            else {
                if (uf.edges[ox] == -1)
                    uf.edges[ox] = y;
                else
                    uf.unite(y, uf.edges[ox]);
                if (uf.edges[oy] == -1)
                    uf.edges[oy] = x;
                else
                    uf.unite(x, uf.edges[oy]);
            }
        }
        else {
            writeln( uf.find(x) == uf.find(y) ? "YES" : "NO" );
        }
    }
}

class UnionFind {
    int N;
    int[] table;
    int[] edges;

    this(int n) {
        N = n;
        table = new int[](N);
        edges = new int[](N);
        fill(table, -1);
        fill(edges, -1);
    }

    int find(int x) {
        return table[x] < 0 ? x : (table[x] = find(table[x]));
    }

    void unite(int x, int y) {
        x = find(x);
        y = find(y);
        if (x == y) return;
        if (table[x] > table[y]) swap(x, y);
        table[x] += table[y];
        table[y] = x;
        if (edges[x] == -1) edges[x] = edges[y];
    }
}
