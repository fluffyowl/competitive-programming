import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto G = new int[][](N);
    auto uf = new UnionFind(N);
    foreach (_; 0..M) {
        s = readln.split.map!(to!int);
        G[s[0]-1] ~= s[1]-1;
        G[s[1]-1] ~= s[0]-1;
        uf.unite(s[0]-1, s[1]-1);
    }

    auto Q = readln.chomp.to!int;
    auto dist = new int[](N);

    while (Q--) {
        auto a = readln.chomp.to!int - 1;
        dist[] = 1 << 29;
        auto pq = new BinaryHeap!(Array!(Tuple!(int, int)), "a[1] > b[1]");
        pq.insert(tuple(a, 0));

        while (!pq.empty) {
            auto n = pq.front[0];
            auto d = pq.front[1];
            pq.removeFront;
            if (dist[n] <= d) continue;
            dist[n] = d;
            foreach (m; G[n]) {
                if (dist[m] <= d + 1) continue;
                pq.insert(tuple(m, d+1));
            }
        }

        auto d = dist.filter!(x => x != 1 << 29).reduce!max;
        int ans = d <= 1 ? 0 : bsr(d-1) + 1;
        writeln(-uf.table[uf.find(a)]-1, " ", ans);
    }
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
