import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long MOD = 10^^9 + 7;


void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto A = readln.split.map!(to!long).array;
    auto uf = new UnionFind(N, A);
    foreach (_; 0..M) {
        s = readln.split.map!(to!int);
        uf.unite(s[0], s[1]);
    }

    int cnt = 0;
    foreach (i; 0..N) cnt += uf.table[i] < 0;
    cnt = 2 * (cnt - 1);

    if (cnt == 0) {
        writeln(0);
        return;
    }
    
    long ans = 0;
    auto pq = new BinaryHeap!(Array!long, "a > b");
    
    foreach (i; 0..N) {
        if (uf.group[i].length >= 1) {
            uf.group[i].sort();
            ans += uf.group[i].front;
            cnt -= 1;
            foreach (j; 1..uf.group[i].length) {
                pq.insert(uf.group[i][j]);
            }
        }
    }

    while (!pq.empty && cnt > 0) {
        ans += pq.front;
        pq.removeFront;
        cnt -= 1;
    }

    if (cnt > 0) {
        writeln("Impossible");
    } else {
        ans.writeln;
    }
}


class UnionFind {
    int N;
    int[] table;
    long[][] group;

    this(int n, long[] a) {
        N = n;
        table = new int[](N);
        fill(table, -1);
        group = new long[][](N);
        foreach (i; 0..N) group[i] = [a[i]];
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
        group[x] ~= group[y];
        group[y] = [];
    }
}
