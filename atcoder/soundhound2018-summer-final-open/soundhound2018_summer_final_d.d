import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto Q = s[1];
    
    auto uf = new UnionFind(N);
    auto added = new bool[int][](N);
    auto G = new bool[int][](N);
    bool[int] used;

    void dfs(int n) {
        if (n in used) return;
        used[n] = true;
        foreach (m; G[n].keys) {
            if (m in used) continue;
            dfs(m);
        }
    }

    while (Q--) {
        auto q = readln.split.map!(to!int);
        int type = q[0];
        int u = q[1] - 1;
        int v = q[2] - 1;
        int up = uf.find(u);
        int vp = v >= 0 ? uf.find(v) : 0;
        if (type == 1) {
            added[u][v] = true;
            added[v][u] = true;
            G[up][vp] = true;
            G[vp][up] = true;
        } else if (type == 2) {
            auto hoge = used.keys.dup;
            foreach (h; hoge) used.remove(h);
            dfs(up);
            foreach (k; used.keys) {
                uf.unite(up, k);
                hoge = G[k].keys.dup;
                foreach (h; hoge) G[k].remove(h);
            }
        } else {
            if (v in added[u] || up == vp) {
                writeln("Yes");
            } else {
                writeln("No");
            }
        }
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
        return table[x] < 0 ? x : find(table[x]);
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
