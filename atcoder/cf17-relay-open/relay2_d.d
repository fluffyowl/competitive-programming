import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;


void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto uf = new UnionFind(N);
    auto edges = new int[][](N);
    foreach (i; 0..M) {
        s = readln.split.map!(to!int);
        uf.unite(s[0]-1, s[1]-1);
        edges[s[0]-1] ~= s[1]-1;
        edges[s[1]-1] ~= s[0]-1;
    }

    long g1, g2, g3;
    foreach (i; 0..N) {
        if (uf.find(i) == uf.find(0)) {
            g1 += edges[i].length.to!int;
        } else if (uf.find(i) == uf.find(1)) {
            g2 += edges[i].length.to!int;
        } else {
            g3 += edges[i].length.to!int;
        }
    }
    g1 /= 2;
    g2 /= 2;
    g3 /= 2;

    long s1 = -uf.table[uf.find(0)];
    long s2 = -uf.table[uf.find(1)];
    long s3 = N - s1 - s2;

    if (s1 < s2) {
        swap(s1, s2);
        swap(g1, g2);
    }

    long hoge = s1 + s3;
    long ans = hoge * (hoge-1) / 2 - g1 - g3 + s2 * (s2-1) / 2 - g2;
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
} import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;


void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto uf = new UnionFind(N);
    auto edges = new int[][](N);
    foreach (i; 0..M) {
        s = readln.split.map!(to!int);
        uf.unite(s[0]-1, s[1]-1);
        edges[s[0]-1] ~= s[1]-1;
        edges[s[1]-1] ~= s[0]-1;
    }

    long g1, g2, g3;
    foreach (i; 0..N) {
        if (uf.find(i) == uf.find(0)) {
            g1 += edges[i].length.to!int;
        } else if (uf.find(i) == uf.find(1)) {
            g2 += edges[i].length.to!int;
        } else {
            g3 += edges[i].length.to!int;
        }
    }
    g1 /= 2;
    g2 /= 2;
    g3 /= 2;

    long s1 = -uf.table[uf.find(0)];
    long s2 = -uf.table[uf.find(1)];
    long s3 = N - s1 - s2;

    if (s1 < s2) {
        swap(s1, s2);
        swap(g1, g2);
    }

    long hoge = s1 + s3;
    long ans = hoge * (hoge-1) / 2 - g1 - g3 + s2 * (s2-1) / 2 - g2;
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
