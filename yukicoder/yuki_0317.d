import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

immutable int INF = 1 << 29;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];


    auto uf = new UnionFind(N);
    foreach (_; 0..M) {
        s = readln.split.map!(to!int);
        uf.unite(s[0]-1, s[1]-1);
    }


    int[int] cnt;
    foreach (i; 0..N)
        if (uf.table[i] < 0)
            cnt[-uf.table[i]] += 1;


    auto dp = new int[](N+1);
    dp.fill(INF);
    dp[0] = -1;

    foreach (i; cnt.keys) {
        for (int j = 1; j * 2 <= cnt[i]; j *= 2)
            for (int k = N - 1; k >= 0; --k)
                if (k + i * j <= N)
                    dp[k + i * j] = min(dp[k + i * j], dp[k] + j);

        int j = cnt[i] - (1 << bsr(cnt[i])) + 1;
        for (int k = N - 1; k >= 0; --k)
            if (k + i * j <= N)
                dp[k + i * j] = min(dp[k + i * j], dp[k] + j);
    }

    iota(1, N+1).map!(i => dp[i] == INF ? -1 : dp[i]).each!writeln;
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

