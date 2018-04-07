import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

const long MOD = 10^^9 + 7;
const long INF = 1L << 59;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto Q = new Tuple!(int, int, long)[](M);
    auto G = new Tuple!(int, long)[][](N);
    auto uf = new UnionFind(N);

    foreach (i; 0..M) {
        s = readln.split.map!(to!int);
        auto L = s[0] - 1;
        auto R = s[1] - 1;
        auto D = s[2].to!long;
        uf.unite(L, R);
        G[L] ~= tuple(R, -D);
        G[R] ~= tuple(L, D);
    }

    auto ans = new long[](N);
    ans.fill(INF);
    foreach (i; 0..N) {
        if (uf.table[i] < 0) {
            ans[i] = 0;
        }
    }


    auto used = new bool[](N);

    bool dfs(int n, long d) {
        if (ans[n] != INF && d != ans[n]) return false;
        if (used[n]) return true;
        used[n] = true;
        ans[n] = d;
        foreach (m; G[n]) {
            if (!dfs(m[0], d+m[1])) return false;
        }
        return true;
    }

    foreach (i; 0..N) {
        if (uf.table[i] >= 0) continue;
        if (!dfs(i, 0)) {
            writeln("No");
            return;
        }
    }

    "Yes".writeln;
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
