import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto N = readln.chomp.to!int;
    auto A = N.iota.map!(_ => readln.chomp.to!int-1).array;
    auto uf = new UnionFind(N);
    foreach (i; 0..N) uf.unite(i, A[i]);

    int ans = 0;
    foreach (i; 0..N) {
        if (uf.table[i] >= 0) continue;
        int n = -uf.table[i];
        if (n % 2) {
            writeln(-1);
            return;
        }
        ans += n / 2;
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
