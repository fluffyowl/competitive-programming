import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip, std.regex;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto P = readln.split.map!(a => a.to!int-1).array;
    auto Q = new int[](N);
    foreach (i; 0..N) Q[P[i]] = i;
    auto uf = new  UnionFind(N);
    foreach (i; 0..M) {
        s = readln.split.map!(to!int);
        int a = s[0] - 1;
        int b = s[1] - 1;
        uf.unite(a, b);
    }

    auto B = new bool[int][](N);
    foreach (i; 0..N) {
        if (uf.find(i) != i) continue;
        foreach (x; uf.group[i]) B[i][x] = true;
    }

    int ans = 0;
    foreach (i; 0..N) {
        int j = uf.find(Q[i]);
        if (i in B[j]) ans += 1;
    }

    ans.writeln;
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
        foreach (i; 0..N) group[i] = [i];
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
        group[x] ~= group[y].dup;
        group[y] = [];
        table[y] = x;
    }
}
