import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long INF = 1L << 59;
immutable long MOD = 10^^9 + 7;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto X = readln.chomp.to!long;
    auto G = new Tuple!(int, long)[][](N);
    auto E = new Tuple!(int, int, long)[](M);
    foreach (i; 0..M) {
        s = readln.split.map!(to!int);
        G[s[0]-1] ~= tuple(s[1]-1, s[2].to!long);
        G[s[1]-1] ~= tuple(s[0]-1, s[2].to!long);
        E[i] = tuple(s[0]-1, s[1]-1, s[2].to!long);
    }
    auto T = new Tuple!(int, long)[][](N);

    E.sort!"a[2] < b[2]"();
    auto uf = new UnionFind(N);
    long mst_cost = 0;

    foreach (e; E) {
        if (uf.find(e[0]) == uf.find(e[1]))
            continue;
        T[e[0]] ~= tuple(e[1], e[2]);
        T[e[1]] ~= tuple(e[0], e[2]);
        uf.unite(e[0], e[1]);
        mst_cost += e[2];
    }

    auto max_edge_cost = new long[][](N, N);

    void dfs(int n, int p, int root, long d) {
        max_edge_cost[root][n] = d;
        foreach (e; T[n]) {
            int m = e[0];
            long c = e[1];
            if (m != p) 
                dfs(m, n, root, max(d, c));
        }
    }

    bool is_safe_edge(Tuple!(int, int, long) e) {
        return max_edge_cost[e[0]][e[1]] >= e[2];
    }

    foreach (i; 0..N)
        dfs(i, -1, i, 0);
    long ans = 0;

    if (mst_cost == X) {
        long safe_edges_cnt = E.map!(e => is_safe_edge(e)).sum;
        ans = (powmod(2, safe_edges_cnt, MOD) - 2) * powmod(2, M - safe_edges_cnt, MOD) % MOD; 
        ans = (ans + MOD) % MOD;
    } else if (mst_cost < X) {
        long diff = X - mst_cost;
        long a = E.map!(e => e[2] - max_edge_cost[e[0]][e[1]] < diff).sum;
        long b = E.map!(e => e[2] - max_edge_cost[e[0]][e[1]] == diff).sum;
        long c = E.map!(e => e[2] - max_edge_cost[e[0]][e[1]] > diff).sum;
        ans = 2 * (powmod(2, b, MOD) - 1) % MOD * powmod(2, c, MOD) % MOD;
        ans = (ans + MOD) % MOD;
    }

    ans.writeln;
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


long powmod(long a, long x, long m) {
    long ret = 1;
    while (x) {
        if (x % 2) ret = ret * a % m;
        a = a * a % m;
        x /= 2;
    }
    return ret;
}
