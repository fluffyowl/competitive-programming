import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;


void main() {
    auto s = readln.split.map!(to!int).array;
    auto N = s[0];
    auto M = s[1];
    auto V = readln.split.map!(to!long).array;
    auto XY = M.iota.map!(_ => readln.split.map!(x => x.to!int - 1).array).array;
    auto uf = new UnionFind(N);

    foreach (i; 0..M) {
        uf.unite(XY[i][0], XY[i][1]);
        uf.num[uf.find(XY[i][0])] += 1;
    }

    long ans = 0;
    foreach (i; 0..N) {
        if (uf.find(i) != i || uf.num[i] == 0) continue;
        long[] v;
        foreach (m; uf.members[i]) v ~= V[m];
        v.sort!"a > b"();
        foreach (j; 0..min(v.length.to!int, uf.num[i])) ans += v[j];
    }

    ans.writeln;
}

class UnionFind {
    int N;
    int[] table;
    int[] num;
    int[][] members;

    this(int n) {
        N = n;
        table = new int[](N);
        fill(table, -1);
        num = new int[](N);
        members = N.iota.map!(i => [i]).array;
    }

    int find(int x) {
        return table[x] < 0 ? x : (table[x] = find(table[x]));
    }

    void unite(int x, int y) {
        x = find(x);
        y = find(y);
        if (x == y) return;
        if (table[x] > table[y]) swap(x, y);
        foreach (m; members[y]) members[x] ~= m;
        members[y] = [];
        num[x] += num[y];
        table[x] += table[y];
        table[y] = x;
    }
}
