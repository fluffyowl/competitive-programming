import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable int INF = 1 << 29;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto K = s[2];
    auto G = new Tuple!(int, long)[][](N);
    auto E = new Tuple!(int, int, long)[](M);
    foreach (i; 0..M) {
        s = readln.split.map!(to!int);
        int u = s[0] - 1;
        int v = s[1] - 1;
        long c = s[2].to!long;
        G[u] ~= tuple(v, c);
        G[v] ~= tuple(u, c);
        E[i] = tuple(u, v, c);
    }
    auto X = K.iota.map!(_ => readln.chomp.to!int - 1).array;

    long ans = 0;
    auto uf = new UnionFind(N);

    foreach (i; X) {
        ans += E[i][2];
        uf.unite(E[i][0], E[i][1]);
    }

    auto pq = new BinaryHeap!(Array!(Tuple!(int, int, long)), "a[2] > b[2]")();
    foreach (e; E) pq.insert(e);

    while (!pq.empty) {
        auto e = pq.front;
        auto u = e[0];
        auto v = e[1];
        auto c = e[2];
        pq.removeFront;
        if (uf.find(u) == uf.find(v)) {
            continue;
        }
        ans += c;
        uf.unite(u, v);
    }

    writeln(E.map!(e => e[2]).sum - ans);
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
        if (table[x] > table[y]) swap(x, y);
        table[x] += table[y];
        table[y] = x;
    }
}

