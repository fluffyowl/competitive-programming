import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto N = readln.chomp.to!int;
    auto D = readln.split.map!(to!int).array;
    auto W = readln.split.map!(to!int).array;

    auto uf = new UnionFind(N);
    auto one = new bool[](N);

    foreach (i; 0..N) {
        auto a = (i + D[i]) % N;
        auto b = (i - D[i]) % N;
        b = (b + N) % N;
        uf.unite(a, b);
        if (a == b) one[a] = true;
    }

    bool ans = true;
    foreach (i; 0..N) {
        if (uf.table[i] >= 0) continue;
        bool ok = false;
        foreach (x; uf.group[i]) if (one[x]) ok = true;
        if (uf.group[i].map!(x => W[x] == 0).sum % 2 == 0) ok = true;
        ans &= ok;
    }

    writeln(ans ? "Yes" : "No");
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
        foreach (i; 0..N) group[i] ~= i;
    }

    int find(int x) {
        return table[x] < 0 ? x : (table[x] = find(table[x]));
    }

    void unite(int x, int y) {
        x = find(x);
        y = find(y);
        if (x == y) return;
        if (table[x] > table[y]) swap(x, y);
        foreach (g; group[y]) group[x] ~= g;
        group[y] = [];
        table[x] += table[y];
        table[y] = x;
    }
}

