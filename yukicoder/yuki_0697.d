import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto s = readln.split.map!(to!int);
    auto H = s[0];
    auto W = s[1];
    auto A = H.iota.map!(_ => readln.split.map!(to!int).array).array;
    const int[] dr = [0, 0, -1, 1];
    const int[] dc = [-1, 1, 0, 0];
    auto uf = new UnionFind(H*W);
    auto used = new bool[](H*W);
    int ans = 0;
    

    foreach (i; 0..H)
        foreach (j; 0..W)
            foreach (k; 0..4)
                if (i+dr[k] >= 0 && i+dr[k] < H)
                    if (j+dc[k] >= 0 && j + dc[k] < W)
                        if (A[i][j] == 1 && A[i+dr[k]][j+dc[k]] == 1)
                            uf.unite(i*W+j, (i+dr[k])*W+j+dc[k]);


    foreach (i; 0..H)
        foreach (j; 0..W)
            if (A[i][j] == 1 && !used[uf.find(i*W+j)])
                ans += 1, used[uf.find(i*W+j)] = true;

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


