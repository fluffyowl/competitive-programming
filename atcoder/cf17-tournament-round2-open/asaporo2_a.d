import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    immutable int INF = 1 << 30;

    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto K = s[2];
    auto C = readln.split.map!(to!int).array;
    auto G = new Tuple!(int, long)[][](N);
    foreach (i; 0..M) {
        s = readln.split.map!(to!int);
        G[s[0]-1] ~= tuple(s[1]-1, s[2].to!long);
        G[s[1]-1] ~= tuple(s[0]-1, s[2].to!long);
    }

    if (K == 1) {
        writeln(0);
        return;
    }

    Tuple!(int, int, long)[] E;
    
    foreach (i; 0..N) {
        int n = C[i] == 0 ? i + N + 1 : C[i];
        foreach (j; G[i]) {
            int m = C[j[0]] == 0 ? j[0] + N + 1 : C[j[0]];
            if (j[0] > i) continue;
            if (n == m) continue;
            E ~= tuple(n, m, j[1]);
        }
    }

    E.sort!"a[2] < b[2]"();
    auto uf = new UnionFind(3*N);
    long ans = 0;
    int cnt = 0;

    foreach (e; E) {
        if (uf.find(e[0]) == uf.find(e[1])) continue;
        uf.unite(e[0], e[1]);
        ans += e[2];
        cnt += 1;
        if (cnt == K-1) {
            ans.writeln;
            return;
        }
    }

    writeln(-1);
}


class UnionFind {
    int N;
    int[] table;
    long[] cost;

    this(int n) {
        N = n;
        table = new int[](N);
        fill(table, -1);
        cost = new long[](N);
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
        cost[x] += cost[y];
    }
}
