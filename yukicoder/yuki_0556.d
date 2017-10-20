import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto uf = new UnionFind(N);

    while (M--) {
        s = readln.split.map!(to!int);
        auto a = s[0] - 1;
        auto b = s[1] - 1;
        uf.unite(a, b);
    }

    foreach (i; 0..N) writeln(uf.find(i) + 1);
}


class UnionFind {
    int N;
    int[] table;

    this(int n) {
        N = n;
        table = new int[](N);
        fill(table, -1);
    }

    int find(int x) {
        return table[x] < 0 ? x : (table[x] = find(table[x]));
    }

    void unite(int x, int y) {
        x = find(x);
        y = find(y);
        if (x == y) return;
        if (table[x] > table[y] || (table[x] == table[y] && y < x)) swap(x, y);
        table[x] += table[y];
        table[y] = x;
    }
}

