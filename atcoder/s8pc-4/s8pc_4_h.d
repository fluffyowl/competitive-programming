import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;

immutable int INF = 1 << 29;
int[][] adj;


void main() {
    auto N = readln.chomp.to!int;
    int E = 0;
    auto uf = new UnionFind(N);
    auto used = new bool[][](N, N);
    auto black = new string[](N);
    foreach (i; 0..N) black[i] = "0";
    string[] ans = ["!"];

    while (E < N - 1) {
        int a = uniform(0, N);
        int b = uniform(0, N);
        if (a == b) continue;
        if (used[a][b]) continue;
        if (uf.find(a) == uf.find(b)) continue;

        black[a] = black[b] = "1";
        writeln("? " ~ black.join(""));
        stdout.flush;
        auto radius = readln.chomp.to!int;
        if (radius == 1) {
            ans ~= ("(" ~ a.to!string ~ "," ~ b.to!string ~ ")");
            uf.unite(a, b);
        }
        E += radius;

        black[a] = black[b] = "0";
        used[a][b] = true;
        used[b][a] = true;
    }

    ans.join(" ").writeln;
    stdout.flush;

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
        if (table[x] < table[y]) swap(x, y);
        table[x] += table[y];
        table[y] = x;
    }
}
