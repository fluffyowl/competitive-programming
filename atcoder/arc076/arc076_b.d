import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

void main() {
    auto N = readln.chomp.to!int;
    auto X = new long[](N);
    auto Y = new long[](N);
    int[][long] Xi;
    int[][long] Yi;
    foreach (i; 0..N) {
        auto s = readln.split.map!(to!long);
        X[i] = s[0];
        Y[i] = s[1];
        Xi[s[0]] ~= i;
        Yi[s[1]] ~= i;
    }

    auto uf = new UnionFind(N);

    foreach (k; Xi.keys) {
        foreach (i; Xi[k])
            uf.unite(i, Xi[k][0]);
    }
    foreach (k; Yi.keys) {
        foreach (i; Yi[k])
            uf.unite(i, Yi[k][0]);
    }

    Tuple!(long, long, int)[] queue;
    auto Xk = Xi.keys.array;
    auto Yk = Yi.keys.array;
    Xk.sort();
    Yk.sort();

    foreach (i; 0..Xk.length.to!int - 1) {
        queue ~= tuple(Xk[i+1], Xk[i], 0);
    }
    foreach (i; 0..Yk.length.to!int - 1) {
        queue ~= tuple(Yk[i+1], Yk[i], 1);
    }

    queue.sort!((a, b) => a[0] - a[1] < b[0] - b[1])();
    long ans = 0;

    foreach (q; queue) {
        if (q[2] == 0) {
            long k1 = q[0];
            long k2 = q[1];
            int i1 = Xi[k1][0];
            int i2 = Xi[k2][0];
            if (uf.find(i1) != uf.find(i2)) {
                ans += k1 - k2;
                uf.unite(i1, i2);
            }
        } else {
            long k1 = q[0];
            long k2 = q[1];
            int i1 = Yi[k1][0];
            int i2 = Yi[k2][0];
            if (uf.find(i1) != uf.find(i2)) {
                ans += k1 - k2;
                uf.unite(i1, i2);
            }
        }
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
